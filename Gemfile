source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

gem 'rails', '~> 6.0.0.beta3'
gem 'pg'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'webpacker', '>= 4.0.0.rc.3'
gem 'react-rails'
gem 'turbolinks', '~> 5', require: false
gem 'jbuilder', '~> 2.5'
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'slim'
gem 'redis'
gem 'redis-namespace'
gem 'bcrypt', '~> 3.1.7'
gem 'scout_apm'
gem 'will_paginate'
gem 'lograge'
gem 'bugsnag'
gem 'inline_svg'
gem 'fast_jsonapi'
gem 'sanitize'
gem 'font-awesome-rails'
gem 'jquery-rails'

gem 'bootsnap', '>= 1.4.1', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'ngrok-tunnel'
  gem 'rack-mini-profiler', require: false
  # gem 'bullet'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener'
  gem 'guard'
  gem 'guard-livereload'
  gem 'guard-rspec', require: false
  gem 'rack-livereload'
  gem 'annotate'
  gem 'rb-readline'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

group :production do
  gem 'newrelic_rpm'
  gem 'dalli'
  gem 'memcachier'
  gem 'connection_pool'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
