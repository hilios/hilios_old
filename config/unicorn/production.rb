app_path = "/var/rails/hilios"

timeout 30
worker_processes 1
working_directory "#{app_path}/current"
listen            "#{app_path}/shared/sockets/unicorn.sock", :backlog => 64

pid               "#{app_path}/shared/pids/unicorn.pid"
stderr_path       "#{app_path}/shared/log/unicorn.stderr.log"
stdout_path       "#{app_path}/shared/log/unicorn.stdout.log"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
