namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end

before "bundle:install", "rvm:trust_rvmrc"