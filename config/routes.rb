Rails.application.routes.draw do
  require 'admin_constraint'
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web, at: '/sidekiq', constraints: AdminConstraint.new

  resources :projects
  resources :posts

  resources :users
  get 'settings', to: 'users#edit', as: 'settings'
  get 'register', to: 'users#new', as: 'register'
  post :register, to: 'users#create'
  get 'login', to: 'sessions#new', as: 'login'
  post :login, to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resource :sessions, only: [:create, :destroy]

  get 'about', to: 'pages#about'
  get 'terms', to: 'pages#terms'
  get 'privacy', to: 'pages#privacy'
  get 'admin', to: 'pages#admin'

  namespace :admin, module: 'admin' do
    resources :users
  end


  root to: 'pages#index'
end
