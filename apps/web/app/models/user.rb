# frozen_string_literal: true

require "openssl"

class User < ApplicationRecord
  # Assemble devise modules based on the instance's login mode. Cloud (OTP)
  # deployments skip :database_authenticatable entirely so the password
  # column — which is still present in the schema — stays unset for every
  # user. Self-host in `password_no_confirmation` mode drops :confirmable so
  # no mailer delivery is ever required (local installs without SMTP).
  _devise_modules = [:registerable, :rememberable, :lockable]
  if Revdoku.password_based_login?
    _devise_modules << :database_authenticatable
    _devise_modules << :validatable   # enforces config.password_length (8..128)
  end
  _devise_modules << :confirmable unless Revdoku.login_mode_password_no_confirmation?
  _devise_modules << :recoverable if Revdoku.login_mode_password? && Revdoku.email_delivery_configured?
  devise(*_devise_modules)

  devise :omniauthable, omniauth_providers: [:google_oauth2] if Revdoku.google_auth_enabled?

  # Let OTP-only accounts exist without a password. When :database_authenticatable
  # isn't loaded this method is never called; when it is loaded we still
  # want OTP-era accounts to bypass the validation (they signed up before
  # the instance flipped to password mode — or an admin created them
  # without a password via `users:set_password`).
  def password_required?
    return false unless Revdoku.password_based_login?
    return false if encrypted_password.blank? && !new_record? && password.blank?
    super
  end

  has_prefix_id :user
  has_encrypted :otp_secret

  # First-user-wins admin bootstrap runs from complete_account_setup!, after
  # the configured login mode has proved control of the email address.

  # Accounts
  has_many :memberships, class_name: "AccountMember", dependent: :destroy
  has_many :accounts, through: :memberships
  has_many :owned_accounts, class_name: "Account", foreign_key: :owner_id, dependent: :destroy, inverse_of: :owner
  has_one :personal_account, -> { where(personal: true) },
          class_name: "Account", foreign_key: :owner_id, inverse_of: :owner

  # Auth
  has_many :api_keys, dependent: :destroy
  has_many :connected_accounts, dependent: :destroy
  has_many :login_histories, dependent: :destroy

  # Notifications
  has_many :notifications, dependent: :destroy

  # Validations
  validates :first_name, presence: true
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false, if: :will_save_change_to_email? }
  validate :email_canonical_must_be_unique, if: :will_save_change_to_email?

  before_validation :set_email_canonical, if: :will_save_change_to_email?
  before_validation :derive_names_from_email_if_blank, on: :create

  GMAIL_DOMAINS = %w[gmail.com googlemail.com].freeze

  def self.canonicalize_email(email)
    return nil if email.blank?

    email = email.downcase.strip
    local, domain = email.split("@", 2)
    return nil unless local && domain

    # Strip +alias for all providers
    local = local.split("+", 2).first

    # Strip dots for Gmail/Googlemail (Gmail ignores dots in local part)
    if GMAIL_DOMAINS.include?(domain)
      local = local.delete(".")
      domain = "gmail.com" # normalize googlemail.com → gmail.com
    end

    "#{local}@#{domain}"
  end


  # 2FA
  attr_accessor :otp_attempt

  def name
    "#{first_name} #{last_name}".strip
  end

  def to_s
    if name.present?
      "#{name} <#{email}>"
    else
      email
    end
  end

  def two_factor_enabled?
    otp_required_for_login?
  end

  def enable_two_factor!
    self.otp_required_for_login = true
    save!
  end

  def disable_two_factor!
    self.otp_required_for_login = false
    self.otp_secret = nil
    self.otp_backup_codes = nil
    save!
  end

  def verify_otp(code)
    return false unless otp_secret.present?

    totp = ROTP::TOTP.new(otp_secret, issuer: "Revdoku")
    result = totp.verify(code, drift_behind: 15, drift_ahead: 15)
    return true if result

    # Check backup codes
    verify_backup_code(code)
  end

  def provisioning_uri
    totp = ROTP::TOTP.new(otp_secret, issuer: "Revdoku")
    totp.provisioning_uri(email)
  end

  def generate_otp_backup_codes!
    codes = 10.times.map { SecureRandom.hex(4) }
    self.otp_backup_codes = codes.map { |c| BCrypt::Password.create(c) }.join(",")
    save!
    codes
  end

  def verify_backup_code(code)
    return false unless otp_backup_codes.present?

    codes = otp_backup_codes.split(",")
    matched_index = codes.index do |stored_code|
      BCrypt::Password.new(stored_code) == code
    rescue BCrypt::Errors::InvalidHash
      false
    end
    return false unless matched_index

    codes.delete_at(matched_index)
    update!(otp_backup_codes: codes.join(","))
    true
  end

  # Email OTP login
  def generate_login_otp!
    code = SecureRandom.random_number(10**6).to_s.rjust(6, "0")
    update!(
      login_otp_digest: self.class.login_otp_digest_for(code),
      login_otp_sent_at: Time.current,
      login_otp_attempts: 0
    )
    code
  end

  def verify_login_otp(code)
    return false if login_otp_digest.blank? || login_otp_sent_at.blank?
    return false if login_otp_sent_at < 10.minutes.ago
    return false if login_otp_attempts >= 5

    expected_digest = self.class.login_otp_digest_for(code)
    if login_otp_digest.bytesize == expected_digest.bytesize &&
       ActiveSupport::SecurityUtils.secure_compare(expected_digest, login_otp_digest)
      clear_login_otp!
      true
    else
      increment!(:login_otp_attempts)
      false
    end
  end

  def clear_login_otp!
    update!(login_otp_digest: nil, login_otp_sent_at: nil, login_otp_attempts: 0)
  end

  # OAuth
  def self.from_omniauth(auth, utm_params: {})
    email = auth.info.email
    raise ActiveRecord::RecordInvalid.new, "Email address missing from OAuth profile" if email.blank?
    raise ActiveRecord::RecordInvalid.new, "Email domain not supported" if respond_to?(:email_domain_disallowed?) && email_domain_disallowed?(email)

    canonical = canonicalize_email(email)
    user = find_by(email_canonical: canonical)

    if user
      # Link connected account if user exists
      user.connected_accounts.find_or_create_by!(
        provider: auth.provider,
        uid: auth.uid
      ) do |ca|
        ca.access_token = auth.credentials.token
        ca.refresh_token = auth.credentials.refresh_token
        ca.expires_at = auth.credentials.expires_at ? Time.at(auth.credentials.expires_at) : nil
      end

      # OAuth proves email ownership — confirm if not yet confirmed, then run deferred setup
      user.confirm unless user.confirmed?
      user.complete_account_setup!

      user
    else
      # Create new user (already confirmed via OAuth — run full setup immediately)
      new_user = create!(
        email: auth.info.email,
        first_name: auth.info.first_name || auth.info.name&.split&.first || "User",
        last_name: auth.info.last_name || auth.info.name&.split&.last || "-",
        provider: auth.provider,
        uid: auth.uid
      ) do |u|
        u.skip_confirmation!
        utm_params.each { |k, v| u[k] = v if column_names.include?(k.to_s) }
        u.connected_accounts.build(
          provider: auth.provider,
          uid: auth.uid,
          access_token: auth.credentials.token,
          refresh_token: auth.credentials.refresh_token,
          expires_at: auth.credentials.expires_at ? Time.at(auth.credentials.expires_at) : nil
        )
      end
      new_user.reload.complete_account_setup!
      new_user
    end
  end

  # Account management
  def create_default_account
    if (account = personal_account)
      return account
    end

    account = owned_accounts.create!(
      name: "#{first_name}'s Personal Account",
      personal: true
    )
    memberships.create!(account: account, role: :owner)
    association(:personal_account).reset
    # Checklists, default plan, and sample envelope created via complete_setup! (called after confirmation or OAuth)
    account
  end

  # Devise's RegistrationsController calls this internally;
  # without :database_authenticatable the method doesn't exist.
  def clean_up_passwords; end

  def has_high_security_account?
    accounts.any?(&:security_level_high?)
  end

  # Devise calls this to determine the remember-me cookie duration.
  # Uses the strictest (shortest) session TTL across all user's accounts.
  def remember_for
    accounts.map(&:session_ttl).min || Account::SECURITY_SETTINGS[:low][:session_ttl]
  end

  # Devise rememberable requires a salt to sign the remember-me cookie.
  # Without :database_authenticatable there is no encrypted_password,
  # so we provide a stable, per-user value instead.
  def rememberable_value
    "#{id}-#{created_at.to_i}-#{updated_at.to_i}-#{otp_required_for_login? ? 1 : 0}"
  end

  def self.redact_email(email)
    local, domain = email.to_s.downcase.strip.split("@", 2)
    return "[blank]" if local.blank? && domain.blank?
    return "[invalid-email]" if domain.blank?

    visible = local[0, 2]
    "#{visible}***@#{domain}"
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[email first_name last_name admin created_at utm_source utm_medium utm_campaign]
  end

  def complete_account_setup!
    return unless email_verified_for_account_setup?

    account = create_default_account
    return unless account

    notify_signup = !account.setup_completed?
    account.complete_setup!
    auto_promote_to_admin_on_fresh_install if Revdoku.password_based_login? && eligible_for_first_user_admin_bootstrap?
    notify_admin_of_signup if notify_signup && account.setup_completed?
  end


  private

  def self.login_otp_digest_for(code)
    key = Rails.application.key_generator.generate_key("revdoku-login-otp-digest", 32)
    OpenSSL::HMAC.hexdigest("SHA256", key, code.to_s)
  end

  def email_canonical_must_be_unique
    return if email_canonical.blank?
    scope = User.where(email_canonical: email_canonical)
    scope = scope.where.not(id: id) if persisted?
    errors.add(:email, "is already taken (an account with this email already exists)") if scope.exists?
  end

  def email_verified_for_account_setup?
    return true unless respond_to?(:confirmed?)
    return true if confirmed?
    return true if respond_to?(:confirmation_required?) && !confirmation_required?

    false
  end

  def set_email_canonical
    self.email_canonical = self.class.canonicalize_email(email)
  end

  # Auto-fill first_name / last_name from the email local-part when they
  # weren't supplied (the simplified email-only signup form). Splits on
  # `.`, `_`, `-`, capitalizes each segment. Skips fields that are
  # already set so OAuth (auth.info.first_name / last_name) and any
  # admin/console-driven creation flows are unaffected.
  def derive_names_from_email_if_blank
    return if email.blank?
    return if first_name.present? && last_name.present?

    local = email.split("@", 2).first.to_s.split("+", 2).first
    parts = local.split(/[._\-]+/).reject(&:blank?).map(&:capitalize)
    return if parts.empty?

    self.first_name = parts.shift if first_name.blank?
    self.last_name  = parts.join(" ") if last_name.blank?
  end


  def notify_admin_of_signup
    UserMailer.signup_notification(self).deliver_later
  rescue => e
    Rails.logger.warn("Failed to send signup notification: #{e.message}")
  end

  # Predicate guard. See docs/first_user_admin_bootstrap.md.
  def eligible_for_first_user_admin_bootstrap?
    return false if ENV.fetch("REVDOKU_DISABLE_FIRST_USER_ADMIN", "false").downcase.in?(%w[true 1 yes])
    User.count == 1
  end

  # Promotes self to global admin.
  def auto_promote_to_admin_on_fresh_install
    update_column(:admin, true)
    Rails.logger.info(
      "[Bootstrap] First user auto-promoted to admin." \
      " login_mode=#{Revdoku.login_mode} user_id=#{id} email=#{self.class.redact_email(email)}"
    )
  end
end
