# config/deploy.rb 
require "bundler/capistrano"

set :scm,             :git
set :repository,      "git@github.com:hilios/hilios.git"
set :branch,          "origin/master"
set :migrate_target,  :current
set :ssh_options,     { :forward_agent => true }
set :deploy_to,       "/var/rapp/hilios"
set :normalize_asset_timestamps, false
set :git_shallow_clone, 1

set :user,            "root"
set :use_sudo,        false

role :web,            "hilios.com.br"
role :app,            "hilios.com.br"
role :db,             "hilios.com.br", :primary => true

set(:latest_release)    { fetch(:current_path) }
set(:release_path)      { fetch(:current_path) }
set(:current_release)   { fetch(:current_path) }

set(:current_revision)  { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:latest_revision)   { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:previous_revision) { capture("cd #{current_path}; git rev-parse --short HEAD@{1}").strip }

default_run_options[:shell] = 'bash'

Dir["./config/capistrano/**/*.rb"].each { |f| require f }

