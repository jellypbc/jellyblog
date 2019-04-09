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

require 'rails_helper'

RSpec.describe ProjectOwnership, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
