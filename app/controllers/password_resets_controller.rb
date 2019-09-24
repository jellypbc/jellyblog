class PasswordResetsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    user.send_password_reset if user
    flash[:notice] = "We'll email you with new password instructions if we find your password laying around."
    redirect_to login_path
  end

  def edit
    redirect_to new_password_reset_path,
      alert: "You're password reset link has expired. You can request a new one below"
  end
end
