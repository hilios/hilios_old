namespace :nginx do
  def nginx
    "/etc/init.d/nginx"
  end
  
  task :start do
    run "#{nginx} start"
  end

  task :stop do
    run "#{nginx} stop"
  end

  task :restart do
    stop
    start
  end
end