ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require 'rails_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rails-controller-testing'
require 'support/signin'
abort("The Rails environment is running in production mode!") if Rails.env.production?

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.

# Checks for pending migrations before tests are run.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  # temporary fix for ActionController::TestCase process
  # e.g. get :index should now look like
  # process :create, method: :post, params: { album: {title: ''} }
  config.include Rails::Controller::Testing::TestProcess
  config.include Rails::Controller::Testing::TemplateAssertions
  config.include Rails::Controller::Testing::Integration
  config.include SignIn, :type => :controller

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # FactoryBot
  config.include FactoryBot::Syntax::Methods
end

# Shoulda::Matchers.configure do |config|
#   config.integrate do |with|
#     with.test_framework :rspec
#     with.library :rails
#   end
# end

# require 'webmock/rspec'
# WebMock.disable_net_connect! allow_localhost: true

# require 'capybara/poltergeist'
# Capybara.javascript_driver = :poltergeist

# require 'sidekiq/testing'
# Sidekiq::Testing.fake!

# VCR.configure do |c|
#   c.cassette_library_dir = 'spec/vcr_cassettes'
#   c.configure_rspec_metadata!
#   c.default_cassette_options = {
#     re_record_interval: 60 * 60 * 24 # 1 day
#   }
#   c.hook_into :webmock
#   c.ignore_request do |request|
#     URI(request.uri).port == 9200
#   end
# end

# def mail_jobs(opts = {})
#   jobs = MailWorker.jobs
#   jobs.select! {|j| j.args[0] == opts[:mailer] } if opts[:mailer]
#   jobs.select! {|j| j.args[1] == opts[:method] } if opts[:method]
#   jobs
# end
