# == Schema Information
#
# Table name: email_tokens
#
#  id         :bigint           not null, primary key
#  user_id    :integer
#  token      :string           not null
#  expires_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EmailToken < ApplicationRecord
  validates :user_id, presence: true
  validates :token, presence: true

  belongs_to :user

  before_validation :generate_token, on: :create
  before_create :set_expiry

  scope :expired, -> { where('expires_at < ?', Time.now) }

  def self.user_from_token(token)
    email_token = find_by token: token
    email_token.user if email_token && email_token.unexpired?
  end

  def unexpired?
    expires_at > Time.now
  end

  def expire!
    self.expires_at = Time.now
    self.save!
  end

  private

  def generate_token
    return unless user_id
    hex = Digest::SHA1.hexdigest [user_id, SecureRandom.base64].join
    self.token = hex[0,30]
  end

  def set_expiry
    self.expires_at ||= 1.week.from_now
  end
end
