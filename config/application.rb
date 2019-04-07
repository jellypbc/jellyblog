require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module JellyApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.eager_load_paths += %W(
      #{config.root}/lib
    )

    config.active_job.queue_adapter = :sidekiq

    config.assets.paths << Rails.root.join('node_modules')
  end
end
