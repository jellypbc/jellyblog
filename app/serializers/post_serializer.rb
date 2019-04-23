class PostSerializer
  include FastJsonapi::ObjectSerializer
  include Rails.application.routes.url_helpers
  attributes :id, :slug, :title, :body, :body_json
end
