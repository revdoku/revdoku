# frozen_string_literal: true

# Sign-in controller used when REVDOKU_LOGIN_MODE is `password` or
# `password_no_confirmation`. Wraps Devise's default sessions controller so we
# can add the same 2FA gate and audit-log hooks that the OTP controller uses.
class Users::PasswordSessionsController < Devise::SessionsController
  include Devise::Controllers::Rememberable

  layout "devise"

  # POST /users/sign_in
  def create
    email = params.dig(:user, :email)&.downcase&.strip
    password = params.dig(:user, :password)

    if email.blank? || password.blank?
      self.resource = resource_class.new(email: email)
      flash.now[:alert] = "Please enter your email and password."
      return render :new, status: :unprocessable_entity
    end

    user = User.find_by(email: email)

    if user&.respond_to?(:access_locked?) && user.access_locked?
      self.resource = resource_class.new(email: email)
      flash.now[:alert] = "Your account is locked. Contact support."
      return render :new, status: :locked
    end

    unless user&.valid_password?(password)
      track_failed_password_attempt(user)
      Rails.logger.warn("[PasswordAuth] Failed sign-in for #{User.redact_email(email)}")
      self.resource = resource_class.new(email: email)
      flash.now[:alert] = "Invalid email or password."
      return render :new, status: :unauthorized
    end

    if user.respond_to?(:confirmation_required?) && user.confirmation_required? && !user.confirmed?
      self.resource = resource_class.new(email: email)
      flash.now[:alert] = "Please confirm your email before signing in."
      return render :new, status: :unauthorized
    end

    if user.two_factor_enabled?
      session[:otp_pending_user_id] = user.id
      session[:otp_pending_2fa_attempts] = 0
      @email = email
      return render "users/otp_sessions/two_factor"
    end

    user.complete_account_setup!
    reset_failed_password_attempts(user)
    sign_in(:user, user, event: :authentication)
    Rails.logger.info("[PasswordAuth] Signed in #{User.redact_email(email)}")
    redirect_to post_login_path(user)
  end

  # GET /users/sign_in
  def new
    return redirect_to after_sign_in_path_for(current_user) if user_signed_in?
    self.resource = resource_class.new(sign_in_params.presence || { email: flash[:email] })
    super
  end

  private

  def sign_in_params
    return {} unless params[:user].is_a?(ActionController::Parameters)
    params.require(:user).permit(:email)
  end

  def post_login_path(user)
    if user.has_high_security_account? && !user.two_factor_enabled?
      flash[:alert] = "Your account requires two-factor authentication. Please set it up to continue."
      users_two_factor_authentication_path
    else
      after_sign_in_path_for(user)
    end
  end

  def track_failed_password_attempt(user)
    return unless user&.respond_to?(:increment_failed_attempts)

    user.increment_failed_attempts
    if user.respond_to?(:failed_attempts) && user.failed_attempts >= user.class.maximum_attempts
      user.lock_access!(send_instructions: false)
    end
  end

  def reset_failed_password_attempts(user)
    return unless user.respond_to?(:reset_failed_attempts!)
    return unless user.respond_to?(:failed_attempts) && user.failed_attempts.positive?

    user.reset_failed_attempts!
  end
end
