# config/deploy.rb 
require "bundler/capistrano"

set :scm,             :git
set :repository,      "git@github.com:hilios/hilios.git"
set :branch,          "origin/master"
set :deploy_to,       "/var/rapp/hilios"
set :git_shallow_clone, 1

set :user,            "root"
set :use_sudo,        false

role :web,            "hilios.com.br"
role :app,            "hilios.com.br"
role :db,             "hilios.com.br", :primary => true

Dir["./config/capistrano/**/*.rb"].each { |f| require f }

