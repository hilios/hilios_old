require ::File.expand_path('../sinatra',  __FILE__)

require 'rack/test'
require 'rspec'

set :environment, :test

Rspec.configure do |config|
  config.include Rack::Test::Methods
end

def app
  Sinatra::Application
end