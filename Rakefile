require 'rubygems'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'

task :environment do
  require ::File.expand_path('../sinatra',  __FILE__)
end

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
  task.pattern    = 'spec/**/*_spec.rb'
end

task :default => [:cucumber, :spec]