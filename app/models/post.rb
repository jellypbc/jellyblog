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

class Post < ApplicationRecord
  include TimeScopes
  include Slugged
  include SlugHistory
  has_rich_text :content

  slug :title, attribute: :slug
  remember_slug

  belongs_to :user

  scope :are_public, -> { where(public: true) }

  validates :title, length: { maximum: 120 }, presence: true

  has_many :comments, as: :commentable

  def to_param
    slug
  end

  def render_body
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
    markdown.render(body)
  end
  
end
