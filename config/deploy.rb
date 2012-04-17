# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

# Load RVM's capistrano plugin.    
require "rvm/capistrano"
# config/deploy.rb 
require "bundler/capistrano"

set :scm,             :git
set :repository,      "git@github.com:hilios/hilios.git"
set :branch,          "master"
set :migrate_target,  :current
set :ssh_options,     { :forward_agent => true }
set :deploy_to,       "/var/rails/hilios"
set :git_shallow_clone, 1

set :user,            "root"
set :use_sudo,        false

role :web,            "hilios.com.br"
role :app,            "hilios.com.br"
role :db,             "hilios.com.br", :primary => true

instance_eval do
  Dir["./config/capistrano/**/*.rb"].each { |f| load f }
end