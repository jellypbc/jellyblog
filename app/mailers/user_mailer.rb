class UserMailer < ApplicationMailer

	def welcome(user_id)
		@user = User.find user_id

    mail to: @user.email,
      subject: 'Hello!'
	end

  def password_reset(user_id)
    @user = User.find user_id

    @reset_url = auto_login user_reset_password_url(@user), @user,
      2.hours.from_now

    mail to: @user.email,
      subject: 'JellyPBC Login Details'
  end


end
