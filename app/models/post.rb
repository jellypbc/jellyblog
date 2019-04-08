# == Schema Information
#
# Table name: posts
#
#  id           :bigint(8)        not null, primary key
#  title        :string
#  body         :text
#  slug         :string
#  public       :boolean
#  published_at :datetime
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Post < ApplicationRecord
  include TimeScopes
  include Slugged
  include SlugHistory

  validates :title, presence: true

  slug :title, attribute: :slug
  remember_slug

  belongs_to :user

  scope :are_public, -> { where(public: true) }


  def to_param
    slug
  end


end
