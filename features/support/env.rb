# Generated by cucumber-sinatra. (2012-02-01 17:26:29 -0200)

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'sinatra.rb')

require 'capybara'
require 'capybara/cucumber'
require 'rspec'

disable :run
set :environment, :test

def app
  Sinatra::Application
end

Capybara.app = app

class SinatraWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  SinatraWorld.new
end