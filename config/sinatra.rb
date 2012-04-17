require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/simple_assets'
require 'sinatra/contrib/all'
require 'haml'
require 'coffee-filter'

# register Sinatra::SimpleAssets
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
# Sprockets assets pipeline
assets do
  css :application, Dir["app/assets/stylesheets/**/*"]
  js  :application, Dir["app/assets/javascripts/**/*"]
end
# Load all files from my app
Dir["./app/**/*.rb"].each { |f| require f }
# Middlewares
use Rack::Session::Pool, :expire_after => 2592000
use Rack::ShowExceptions