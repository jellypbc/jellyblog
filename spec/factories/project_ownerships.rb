# == Schema Information
#
# Table name: project_ownerships
#
#  id         :bigint(8)        not null, primary key
#  project_id :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :project_ownership do
    
  end
end
