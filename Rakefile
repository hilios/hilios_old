#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rake/rdoctask'
  RDoc::Task = Rake::RDocTask
end

task :environment do
  require ::File.expand_path('../sinatra',  __FILE__)
end

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
  task.pattern    = 'spec/**/*_spec.rb'
end

task :default => [:cucumber, :spec]

namespace :assets do
  desc 'Precompile assets'
  task :precompile do
   Sinatra::Application.assets.precompile
  end
end

Bundler::GemHelper.install_tasks