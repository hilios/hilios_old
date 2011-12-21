require 'rubygems'
require 'bundler/setup'
# Setup sprokects
environment = Sprockets::Environment.new
environment.append_path 'app/assets/javascripts'
# Load all files from my app
Dir["./app/**/*.rb")].each { |f| require f }
run Sinatra::Application