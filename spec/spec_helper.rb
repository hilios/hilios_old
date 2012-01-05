require ::File.expand_path('../sinatra',  File.dirname(__FILE__))

require 'rack/test'
require 'rspec'
require 'capybara/rspec'
require 'database_cleaner'

disable :run
set :environment, :test

def app
  Sinatra::Application
end

Capybara.app = app
# Set the capybara js driver
# Capybara.javascript_driver = :webkit

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.expand_path('support/**/*.rb',  File.dirname(__FILE__))].each {|f| require f}

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.mock_with :rspec

  config.before(:suite) do
    # Ensure that the test db is clean
    # DatabaseCleaner.clean_with :truncation
  end
end