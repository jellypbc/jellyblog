# == Schema Information
#
# Table name: posts
#
#  id           :bigint(8)        not null, primary key
#  title        :string
#  body         :text
#  body_json    :jsonb
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

  slug :title, attribute: :slug
  remember_slug

  belongs_to :user

  scope :are_public, -> { where(public: true) }

  has_many :comments, as: :commentable

  def to_param
    slug
  end

  def render_body
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
    markdown.render(body)
  end
  
  def self.find_by_id_or_slug(param)
    if (param.is_a? Integer) || (param.to_i == true)
      Post.find param
    else
      Post.where("lower(slug) = lower(:param)", param: param).first
    end
  end


end
