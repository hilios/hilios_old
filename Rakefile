#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

# begin
#   require 'rdoc/task'
# rescue LoadError
#   require 'rdoc/rdoc'
#   require 'rake/rdoctask'
#   RDoc::Task = Rake::RDocTask
# end

task :environment do
  require ::File.expand_path('../config/sinatra',  __FILE__)
end

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
  task.pattern    = 'spec/**/*_spec.rb'
end

require 'rake/sprocketstask'
Rake::SprocketsTask.new do |t|
  t.environment = Sprockets::Environment.new
  t.output      = "./public/assets"
  t.assets      = %w( application.js application.css )
end

# task :default => [:cucumber, :spec]

# namespace :assets do
#   desc 'Precompile assets'
#   task :precompile => [:clean_all] do
#     settings.sprockets.each_file do |path|
#       asset = settings.sprockets.find_asset(path)
#       asset.write_to(assets_path.join(asset.digest_path))
#     end
#   end

#   task :clean_all => [:environment] do
#     Dir[assets_path.join('*')].each { |file| FileUtils.rm_rf(file) }
#   end

#   def assets_path
#     @assets_path ||= ::Pathname.new(settings.public_folder).join("assets")
#   end
# end

namespace :db do
  task :migrate do; end
end