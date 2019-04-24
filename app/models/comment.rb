# == Schema Information
#
# Table name: comments
#
#  id               :bigint(8)        not null, primary key
#  user_id          :bigint(8)
#  commentable_id   :integer
#  commentable_type :string
#  content          :string(1000)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ApplicationRecord

  validates :user_id, presence: true
  validates :commentable, presence: true
  validates :content, presence: true, length: { maximum: 2500 }

  belongs_to :commentable, polymorphic: true, touch: true
  belongs_to :user, touch: true

  scope :by_user, ->(user) { where user_id: user.id }

end
