class EmailTokenController < ApplicationController
  def login_and_redirect
    user = EmailToken.user_from_token(params[:token])

    redirect_path = root_path

    if user
      login(user)
      redirect_path = settings_path
    end

    redirect_to redirect_path, notice: "You've been logged in, please update your password."
  end
end
