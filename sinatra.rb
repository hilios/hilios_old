require 'rubygems'
require 'bundler/setup'
require 'sprockets'
require 'sinatra'
# Some setups
ENV['RACK_ENV'] ||= :development

set :root,  File.expand_path('../', __FILE__)
set :views, File.join(settings.root, 'app', 'views')

set :haml, :format => :html5

# Load all files from my app
Dir["./app/**/*.rb"].each { |f| require f }

# Configure sprockets
sprockets = Sprockets::Environment.new
sprockets.append_path 'assets/javascripts'
sprockets.append_path 'assets/stylesheets'
sprockets.append_path 'assets/images'
set :sprockets, sprockets