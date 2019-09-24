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

class PostSerializer
  include FastJsonapi::ObjectSerializer
  include Rails.application.routes.url_helpers
  attributes :id, :slug, :title, :body, :body_json

  # attribute :rendered_markdown do |post|
  # 	post.render_body
  # end
end
