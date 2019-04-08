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

FactoryBot.define do
  factory :user do
    email { generate :email_address }
    first_name { 'Arya' }
    last_name { 'Stark' }
    sequence(:username) {|n| "user#{n}" }

    password { 'password' }

    trait :admin do
      admin { true }
    end

    # trait :avatar do
    #   avatar { 'some_avatar_url.jpg' }
    #   association :user_avatar, factory: :images_user_avatar
    # end

    factory :admin, traits: [:admin]
    # factory :user_with_avatar, traits: [:avatar]
  end
end
