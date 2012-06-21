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
  set :sprockets, sprockets
  # Load all assets
  Dir['app/assets/*'].each { |path| sprockets.append_path(path) }
  # Configure Sprockets::Helpers
  Sprockets::Helpers.configure do |config|
    config.environment = sprockets
    # Change the assets prefix on production
    if ENV['RACK_ENV'] == "production"
      config.digest     = true
      config.compile    = true
      config.compress   = true
      config.prefix     = 'http://cdn.hilios.com.br/assets'
      config.manifest_path = "public/assets"
      # :digest => true, 
      # :debug => false, 
      # :compile => false, 
      # :compress => true,
      # :prefix => "assets", 
      # :host => nil, 
      # :relative_url_root => ENV['RACK_RELATIVE_URL_ROOT'],
      # :precompile => [ /\w+\.(?!js|css).+/, /application.(css|js)$/ ], 
      # :manifest_path => "public/assets",
      # :app => nil
      
    end
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