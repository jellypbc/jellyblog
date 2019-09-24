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

require 'rails_helper'

RSpec.describe EmailToken, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
