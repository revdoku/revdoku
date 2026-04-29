# frozen_string_literal: true

class ReportShare < AccountRecord
  include AccountEncryptable

  has_prefix_id :rshr

  TOKEN_BYTES = 32
  DEFAULT_SHARE_LINK_EXPIRATION = begin
    days = ENV.fetch("DEFAULT_SHARE_LINK_EXPIRATION", "30").to_i
    days.positive? ? days : 30
  end
  MAX_HTML_BYTES = 75.megabytes

  has_encrypted :token, key: :lockbox_encryption_key

  belongs_to :account
  belongs_to :report
  belongs_to :envelope
  belongs_to :envelope_revision
  belongs_to :created_by, class_name: "User"

  has_one_attached :html_file, service: :shared_reports

  validates :token_digest, presence: true, uniqueness: true
  validates :expired_at, presence: true
  validates :view_count, numericality: { greater_than_or_equal_to: 0 }
  validate :expired_at_is_in_the_future, on: :create
  validate :expired_at_within_account_policy, on: :create
  validate :account_allows_report_sharing, on: :create

  scope :active, -> { where("expired_at > ?", Time.current) }
  scope :expired, -> { where("expired_at <= ?", Time.current) }

  def self.generate_token
    SecureRandom.urlsafe_base64(TOKEN_BYTES)
  end

  def self.digest_token(token)
    OpenSSL::HMAC.hexdigest("SHA256", Rails.application.secret_key_base, token.to_s)
  end

  def self.find_by_token(token)
    return nil if token.blank?

    digest = digest_token(token)
    ActsAsTenant.without_tenant do
      includes(:account, html_file_attachment: :blob).find_by(token_digest: digest)
    end
  end

  def attach_html!(html, trusted_append_html: nil)
    normalized_html = self.class.normalize_html(html)
    normalized_html = self.class.inject_before_body_end(normalized_html, trusted_append_html) if trusted_append_html.present?
    raise ArgumentError, "Shared report HTML is empty" if normalized_html.blank?
    raise ArgumentError, "Shared report HTML is too large" if normalized_html.bytesize > MAX_HTML_BYTES

    update!(
      html_sha256: Digest::SHA256.hexdigest(normalized_html),
      byte_size: normalized_html.bytesize
    )

    html_file.attach(
      io: StringIO.new(normalized_html),
      filename: storage_filename,
      content_type: "text/html"
    )
  end

  # Public share viewer (`ReportSharesController#show`) gates on this. If it
  # returns false the request is answered with a 410 Gone / 404 Not Found
  # without serving any HTML, regardless of how the token was obtained.
  #
  # The HIPAA / high-security checks below are redundant with
  # `account.report_sharing_allowed?` (which already includes them) — they're
  # repeated explicitly so the policy is self-documenting and survives any
  # future refactor of `report_sharing_allowed?`. The DB rows are *not*
  # mutated when HIPAA flips on; we keep the audit history intact and simply
  # refuse to serve the content.
  def available?
    return false if account.nil?
    return false if account.hipaa_enabled?
    return false if account.security_level_high?
    return false unless account.report_sharing_allowed?
    return false if expired?
    return false unless html_file.attached?

    true
  end

  def active?
    !expired?
  end

  def expired?
    expired_at.blank? || expired_at <= Time.current
  end

  def record_view!
    ActsAsTenant.without_tenant do
      self.class.where(id: id).update_all([
        "view_count = COALESCE(view_count, 0) + 1, last_viewed_at = ?",
        Time.current
      ])
    end
  end

  def expire!
    update!(expired_at: Time.current)
  end

  def self.normalize_html(html)
    document = Nokogiri::HTML(html.to_s.sub(/\A\xEF\xBB\xBF/, ""))
    document.css("#revdoku-toolbar, #revdoku-panel, .revdoku-panel-overlay, .revdoku-gear, script").remove

    document.traverse do |node|
      next unless node.element?

      node.attribute_nodes.each do |attr|
        value = attr.value.to_s
        node.remove_attribute(attr.name) if attr.name.downcase.start_with?("on") || value.match?(/\A\s*javascript:/i)
      end
    end

    "<!DOCTYPE html>\n#{document.at("html")&.to_html || document.to_html}"
  end

  def self.inject_before_body_end(html, fragment)
    return html if fragment.blank?

    if html.match?(%r{</body>}i)
      html.sub(%r{</body>}i, "#{fragment}\n</body>")
    else
      "#{html}\n#{fragment}"
    end
  end

  private

  def storage_filename
    safe_title = title.to_s.parameterize.presence || report.prefix_id
    "#{safe_title}-#{prefix_id}.html"
  end

  def expired_at_is_in_the_future
    return if expired_at.blank? || expired_at.future?

    errors.add(:expired_at, "must be in the future")
  end

  def expired_at_within_account_policy
    return if expired_at.blank? || account.blank?

    max_days = account.report_share_max_days.to_i
    return if max_days.positive? && expired_at <= max_days.days.from_now

    errors.add(:expired_at, "exceeds account sharing policy")
  end

  def account_allows_report_sharing
    return if account&.report_sharing_allowed?

    errors.add(:base, "Report sharing is disabled for this account")
  end
end
