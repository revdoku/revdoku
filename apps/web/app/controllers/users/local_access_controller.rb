# frozen_string_literal: true

class Users::LocalAccessController < ApplicationController
  layout "devise"

  def show
    result = Revdoku::LocalAccess.consume!(params[:local_access_token], request: request)

    if result.success?
      reset_session
      sign_in(:user, result.user, event: :authentication)
      redirect_to after_sign_in_path_for(result.user)
    else
      redirect_to new_user_session_path, alert: result.error
    end
  end
end
