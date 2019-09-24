# == Schema Information
#
# Table name: posts
#
#  id           :bigint           not null, primary key
#  title        :string
#  body         :text
#  body_json    :jsonb
#  slug         :string
#  public       :boolean
#  published_at :datetime
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  project_id   :integer
#

FactoryBot.define do
  factory :post do
  	title { "My post" }
  	user
    
  end
end
