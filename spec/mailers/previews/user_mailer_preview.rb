class UserMailerPreview < ActionMailer::Preview

  def welcome
    UserMailer.welcome user
  end

  def password_reset
    UserMailer.password_reset user.id
  end

  private
    def user
      User.last
    end
end