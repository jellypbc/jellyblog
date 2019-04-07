Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.keep_original_rails_log = false

  config.lograge.custom_options = lambda do |event|
    params = event.payload[:params].reject { |k| %w(controller action).include?(k) }
    { params: params }
  end
end
