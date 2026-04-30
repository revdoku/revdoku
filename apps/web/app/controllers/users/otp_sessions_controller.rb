# frozen_string_literal: true

class Users::OtpSessionsController < DeviseController
  include Devise::Controllers::Rememberable
  include EmailOtpConfirmationFlow
  include RateLimitedEmailCache

  MAX_TWO_FACTOR_ATTEMPTS = 5

  layout "devise"

  before_action :ensure_email_auth_enabled!, only: [:create]

  # GET /users/sign_in
  def new
    return redirect_to after_sign_in_path_for(current_user) if user_signed_in?

    # When redirected from Google OAuth, show the OTP verify page directly
    if params[:oauth_verified].present? && params[:email].present?
      @email = params[:email]
      return render :verify
    end

    @email = params[:email].presence || flash[:email]
  end

  # POST /users/sign_in
  def create
    email = params[:email]&.downcase&.strip
    @email = email

    if email.blank?
      flash.now[:alert] = "Please enter your email address."
      return render :new, status: :unprocessable_entity
    end

    user = find_user_by_canonical_email(email)

    if user&.respond_to?(:access_locked?) && user.access_locked?
      Rails.logger.warn("[OTP] Login code blocked for locked user #{User.redact_email(email)}")
      flash.now[:alert] = "Your account is locked. Contact support."
      return render :new, status: :locked
    end

    if user
      return send_signup_confirmation_otp(user, submitted_email: email) if signup_confirmation_pending?(user)

      return send_login_otp(user, submitted_email: email)
    elsif sign_in_auto_signup_enabled?
      return create_signup_from_sign_in(email)
    else
      Rails.logger.info("[OTP] Login code requested for unknown email #{User.redact_email(email)}")
    end

    # Paranoid mode: always show "code sent" regardless of email existence
    flash.now[:notice] = "If this email is registered, a 6-digit code was sent to #{email}."
    render :verify, status: :unprocessable_entity
  end

  # POST /users/sign_in/verify
  def verify
    email = params[:email]&.downcase&.strip
    code = params[:code]&.strip
    @email = email

    if email.blank? || code.blank?
      flash.now[:alert] = "Please enter your email and verification code."
      return render :verify, status: :unprocessable_entity
    end

    user = find_user_by_canonical_email(email)

    if user&.respond_to?(:access_locked?) && user.access_locked?
      Rails.logger.warn("[OTP] Login code verification blocked for locked user #{User.redact_email(email)}")
      flash.now[:alert] = "Your account is locked. Contact support."
      return render :verify, status: :locked
    end

    if user&.verify_login_otp(code)
      Rails.logger.info("[OTP] Login code verified for #{User.redact_email(email)}")

      # OTP verification proves email ownership — confirm if not yet confirmed.
      user.confirm unless user.confirmed?
      user.complete_account_setup!

      if user.two_factor_enabled?
        # Store user ID in session for 2FA verification step
        session[:otp_pending_user_id] = user.id
        session[:otp_pending_2fa_attempts] = 0
        return render :two_factor
      end

      sign_in(:user, user, event: :authentication)
      redirect_to post_login_path(user)
    else
      Rails.logger.warn("[OTP] Failed login code verification for #{User.redact_email(email)}")
      flash.now[:alert] = "Invalid or expired code. Please try again."
      render :verify, status: :unprocessable_entity
    end
  end

  # POST /users/sign_in/two_factor
  def two_factor_verify
    user = User.find_by(id: session[:otp_pending_user_id])

    unless user
      redirect_to new_user_session_path, alert: "Session expired. Please sign in again."
      return
    end

    if user.respond_to?(:access_locked?) && user.access_locked?
      session.delete(:otp_pending_user_id)
      session.delete(:otp_pending_2fa_attempts)
      redirect_to new_user_session_path, alert: "Your account is locked. Contact support."
      return
    end

    if user.verify_otp(params[:otp_attempt])
      session.delete(:otp_pending_user_id)
      session.delete(:otp_pending_2fa_attempts)
      user.complete_account_setup!
      sign_in(:user, user, event: :authentication)
      redirect_to post_login_path(user)
    else
      attempts = session[:otp_pending_2fa_attempts].to_i + 1
      session[:otp_pending_2fa_attempts] = attempts
      if attempts >= MAX_TWO_FACTOR_ATTEMPTS
        session.delete(:otp_pending_user_id)
        session.delete(:otp_pending_2fa_attempts)
        redirect_to new_user_session_path, alert: "Too many verification attempts. Please sign in again."
        return
      end

      flash.now[:alert] = "Invalid verification code. Please try again."
      render :two_factor, status: :unprocessable_entity
    end
  end

  private

  # Redirect to 2FA setup if any of user's accounts require it and they haven't set it up
  def post_login_path(user)
    if user.has_high_security_account? && !user.two_factor_enabled?
      flash[:alert] = "Your account requires two-factor authentication. Please set it up to continue."
      users_two_factor_authentication_path
    else
      after_sign_in_path_for(user)
    end
  end

  def ensure_email_auth_enabled!
    unless Revdoku.login_mode_otp?
      redirect_to new_user_session_path, alert: "Email OTP sign-in is not available on this instance."
    end
  end

  def send_login_otp(user, submitted_email:)
    # Rate limit by stored account email so plus aliases cannot bypass it.
    sent_count = otp_send_count(user.email)
    if sent_count >= 3
      flash.now[:alert] = "Too many code requests. Please wait a few minutes."
      return render :new, status: :too_many_requests
    end

    code = user.generate_login_otp!
    increment_otp_send_count(user.email)
    UserMailer.login_otp(user, code).deliver_later
    Rails.logger.info("[OTP] Login code sent to #{User.redact_email(user.email)}")

    @email = submitted_email
    flash.now[:notice] = "If this email is registered, a 6-digit code was sent to #{submitted_email}."
    render :verify, status: :unprocessable_entity
  end

  def signup_confirmation_pending?(user)
    Revdoku.login_mode_otp? &&
      user.respond_to?(:confirmed?) &&
      !user.confirmed?
  end

  def send_signup_confirmation_otp(user, submitted_email:)
    sent_count = otp_send_count(user.email)
    if sent_count >= 3
      @email = submitted_email
      flash.now[:alert] = "Too many code requests. Please wait a few minutes."
      return render :new, status: :too_many_requests
    end

    issue_signup_confirmation_otp!(user)
    increment_otp_send_count(user.email)
    redirect_to signup_confirmation_path_for(user)
  end

  def create_signup_from_sign_in(email)
    user = User.new(email: email)
    if session[:utm_params].present?
      session[:utm_params].slice(*ApplicationController::UTM_KEYS).each do |key, value|
        user[key] = value if User.column_names.include?(key.to_s)
      end
    end
    user.skip_confirmation_notification! if user.respond_to?(:skip_confirmation_notification!)

    if user.save
      return send_signup_confirmation_otp(user, submitted_email: email)
    end

    if (existing_user = find_user_by_canonical_email(email))
      return send_login_otp(existing_user, submitted_email: email)
    end

    Rails.logger.info("[OTP] Auto signup failed for #{User.redact_email(email)}: #{user.errors.full_messages.inspect}")
    @email = email
    flash.now[:alert] = user.errors.full_messages.to_sentence.presence || "We could not start sign-up for this email."
    render :new, status: :unprocessable_entity
  rescue ActiveRecord::RecordNotUnique
    if (existing_user = find_user_by_canonical_email(email))
      return send_login_otp(existing_user, submitted_email: email)
    end

    raise
  end

  def sign_in_auto_signup_enabled?
    Revdoku.registration_enabled? && Revdoku.sign_in_auto_signup_enabled?
  end
end
