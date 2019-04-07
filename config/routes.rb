Rails.application.routes.draw do
  require 'admin_constraint'
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web, at: '/sidekiq', constraints: AdminConstraint.new

  root to: 'pages#index'
end
