# == Schema Information
#
# Table name: users
#
#  id                      :bigint           not null, primary key
#  email                   :string
#  username                :string
#  first_name              :string
#  last_name               :string
#  password_digest         :string
#  admin                   :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  newsletter_signed_up_at :datetime
#

class User < ApplicationRecord
  include TimeScopes

  has_secure_password

  has_many :posts

  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  VALID_USERNAME_REGEX = /\A[0-9a-z_-]+\z/i

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 5, maximum: 300 }, on: :create

  before_save :set_username
  after_create :send_slack_invite

  has_many :comments

  scope :newsletter_subscribed, -> { where.not(newsletter_signed_up_at: nil) }

  def to_param
    username
  end

  def full_name
    if first_name && last_name
      [first_name, last_name].join(" ")
    elsif !first_name
      last_name
    elsif !last_name
      first_name
    else
      "#{first_name} #{last_name}"
    end
  end

  def send_welcome_email
    UserMailer.welcome(id).deliver_now
  end

  def send_password_reset
    SendPasswordResetMailerJob.perform_later(id)
  end

  def send_slack_invite
    SlackInviter.send_slack_invite(email)
  end

  private

    def set_username
      self.username = self.email[/^[^@]+/]
    end

end
