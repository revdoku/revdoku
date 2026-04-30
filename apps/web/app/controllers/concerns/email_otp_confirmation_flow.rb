# frozen_string_literal: true

module EmailOtpConfirmationFlow
  extend ActiveSupport::Concern

  SIGNUP_CONFIRMATION_TOKEN_PURPOSE = :signup_confirmation
  SIGNUP_CONFIRMATION_TOKEN_TTL = 15.minutes

  private

  def find_user_by_canonical_email(email)
    canonical = User.canonicalize_email(email)
    return nil if canonical.blank?

    User.find_by(email_canonical: canonical)
  end

  def issue_signup_confirmation_otp!(user)
    code = user.generate_login_otp!
    UserMailer.confirmation_otp(user, code).deliver_later
    Rails.logger.info("[OTP] Confirmation code sent to #{User.redact_email(user.email)}")
    remember_signup_confirmation(user)
    code
  end

  def remember_signup_confirmation(user)
    session[:confirmation_email] = user.email
    session[:confirmation_user_id] = user.id
  end

  def signup_confirmation_token(user)
    user.signed_id(
      purpose: SIGNUP_CONFIRMATION_TOKEN_PURPOSE,
      expires_in: SIGNUP_CONFIRMATION_TOKEN_TTL
    )
  end

  def signup_confirmation_path_for(user)
    users_confirm_email_path(confirmation_token: signup_confirmation_token(user))
  end

  def signup_confirmation_user_from_token(token)
    return nil if token.blank?

    User.find_signed(token, purpose: SIGNUP_CONFIRMATION_TOKEN_PURPOSE)
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end

  def signup_confirmation_user_from_session
    return nil if session[:confirmation_user_id].blank?

    User.find_by(id: session[:confirmation_user_id])
  end

  def signup_confirmation_user_from_params_or_session
    signup_confirmation_user_from_token(params[:confirmation_token]) ||
      signup_confirmation_user_from_session
  end
end
