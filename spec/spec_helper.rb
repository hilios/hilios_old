require ::File.expand_path('../sinatra',  __FILE__)

require 'rack/test'
require 'rspec'
require 'capybara/rspec'
require 'database_cleaner'

# Set the capybara js driver
# Capybara.javascript_driver = :webkit

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

set :environment, :test

Rspec.configure do |config|
  config.include Rack::Test::Methods
  config.mock_with :rspec
  config.use_transactional_fixtures = true

  config.before(:suite) do
    # Ensure that the test db is clean
    # DatabaseCleaner.clean_with :truncation
  end
end

def app
  Sinatra::Application
end