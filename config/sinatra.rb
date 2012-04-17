require 'rubygems'
require 'bundler/setup'
require 'sprockets'
require 'sinatra'
require 'sinatra/contrib/all'
require 'haml'
require 'coffee-filter'

# Enviroment settings
enable :logging, :dump_errors
disable :static
# View settings
set :views, 'app/views'
set :haml, 
  :ugly   => true,
  :format => :html5, 
  :layout => :'layouts/application'
# Sessions
enable :sessions
set :session_secret, '1Gikx4OTdoQp9OLjxfK76NBm065IzPkYTAirE8iUT5wgXAIW30dbjxOr5riSvRrKEQ7JxDsk7Kfz363Vif2erbgSZt3Xjh6hs8ZX8cO6X0ntzYYhgYzUmedQG8WielBh'
# Configure sprockets
sprockets = Sprockets::Environment.new
sprockets.append_path 'app/assets/javascripts'
sprockets.append_path 'app/assets/stylesheets'
sprockets.append_path 'app/assets/images'
set :sprockets, sprockets
# Middlewares
use Rack::Session::Pool, :expire_after => 2592000
use Rack::ShowExceptions
# Load all files from my app
Dir["./app/**/*.rb"].each { |f| require f }