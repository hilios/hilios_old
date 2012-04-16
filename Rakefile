require 'rubygems'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'
require 'sprockets/rake/sprocketstask'

task :environment do
  require ::File.expand_path('../sinatra',  __FILE__)
end

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
  task.pattern    = 'spec/**/*_spec.rb'
end

Rake::SprocketsTask.new do |t|
  t.environment = Sprockets::Environment.new
  t.keep        = 2
  t.output      = "./public/assets"
  t.assets      = %w( application.js application.css )
end

task :default => [:cucumber, :spec]