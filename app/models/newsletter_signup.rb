# == Schema Information
#
# Table name: newsletter_signups
#
#  id         :bigint           not null, primary key
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class NewsletterSignup < ApplicationRecord
end
