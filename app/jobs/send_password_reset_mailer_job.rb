class SendPasswordResetMailerJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    UserMailer.password_reset(user_id).deliver
  end
end
