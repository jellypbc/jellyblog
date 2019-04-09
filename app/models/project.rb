# == Schema Information
#
# Table name: projects
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Project < ApplicationRecord

  has_many :posts

  has_many :project_ownerships
  has_many :users, through: :project_ownerships

end
