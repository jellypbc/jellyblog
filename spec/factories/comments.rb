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

FactoryBot.define do
  factory :comment do
  	user
    commentable { user }
    content { 'Some witty comment' }
  end
end
