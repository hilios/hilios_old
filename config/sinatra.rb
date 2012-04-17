require 'rubygems'
require 'bundler/setup'
# WebServer
require 'sinatra'
require 'sinatra/contrib/all'
# Assets pipeline
require 'sprockets'
require 'sprockets-helpers'
# Processors
require 'haml'
require 'coffee-filter'

configure do
  # Enviroment settings
  enable :logging, :dump_errors
  # View
  set :views, 'app/views'
  set :haml, 
    :ugly   => true,
    :format => :html5, 
    :layout => :'layouts/application'
  # Sessions
  enable :sessions
  set :session_secret, '1Gikx4OTdoQp9OLjxfK76NBm065IzPkYTAirE8iUT5wgXAIW30dbjxOr5riSvRrKEQ7JxDsk7Kfz363Vif2erbgSZt3Xjh6hs8ZX8cO6X0ntzYYhgYzUmedQG8WielBh'
  # Sprockets
  sprockets = Sprockets::Environment.new
  Dir['app/assets/*'].each { |path| sprockets.append_path(path) }
  # sprockets.append_path 'app/assets/javascripts'
  # sprockets.append_path 'app/assets/stylesheets'
  # sprockets.append_path 'app/assets/images'
  set :sprockets, sprockets

  # Configure Sprockets::Helpers
  Sprockets::Helpers.configure do |config|
    config.environment = sprockets
    config.digest      = true
  end

  helpers do
    include Sprockets::Helpers
  end

  # Middlewares
  use Rack::Session::Pool, :expire_after => 2592000
  use Rack::ShowExceptions
end

# Load all files from my app
Dir["./app/**/*.rb"].each { |f| require f }