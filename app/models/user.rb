# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string
#  username        :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  admin           :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
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

  has_many :comments

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

  private

    def set_username
      self.username = self.email[/^[^@]+/]
    end

end
