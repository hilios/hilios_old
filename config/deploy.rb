require "capistrano_colors"
# App config
set :application,         "hilios"
set :deploy_to,           "/var/ruby/#{application}"
# Custom recepies
require "bundler/capistrano"  # Bundler 
require "rvm/capistrano"      # RVM
require "capistrano-unicorn"  # Unicorn
# Server config
set :user,                "ubuntu"
set :use_sudo,            false
role :web,                "hilios.com.br"
role :app,                "hilios.com.br"
role :db,                 "hilios.com.br", :primary => true
# GIT config
set :scm,                 :git
set :repository,          "git@github.com:hilios/#{application}.git"
set :branch,              "master"
set :scm_verbose,         true
# RVM config
set :rvm_ruby_string, "1.9.3@#{application}"
# set :rvm_type,        :system  # Copy the exact line. I really mean :system here