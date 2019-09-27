Rails.application.routes.draw do
  require 'admin_constraint'
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web, at: '/sidekiq', constraints: AdminConstraint.new

  resources :posts do
    resources :comments
  end

  resources :users do
    get :reset_password, as: :reset_password
  end

  resources :newsletter_signups
  
  get 'settings', to: 'users#edit', as: 'settings'
  get 'register', to: 'users#new', as: 'register'
  post :register, to: 'users#create'
  get 'login', to: 'sessions#new', as: 'login'
  post :login, to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :comments

  resource :sessions, only: [:create, :destroy]

  get 'about', to: 'pages#about'
  get 'terms', to: 'pages#terms'
  get 'privacy', to: 'pages#privacy'
  get 'admin', to: 'pages#admin'

  namespace :admin, module: 'admin' do
    resources :users
    resources :posts
    resources :newsletter_signups
  end

  get 'dashboard', to: 'pages#dashboard'
  get 'follow', to: 'pages#follow'

  get "password_resets/new"
  get 'et/:token/*path', to: 'email_token#login_and_redirect'
  resources :password_resets, only: [:create, :edit]

  root to: 'pages#index'
end
