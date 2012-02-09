# Set environment to development unless something else is specified
env = ENV["ENV"] || "development"

root_path = File.expand_path('../../', File.dirname(__FILE__))
shared_path = "#{root_path}/shared"

# See http://unicorn.bogomips.org/Unicorn/Configurator.html for complete
# documentation.

worker_processes 4

# listen on both a Unix domain socket and a TCP port,
# we use a shorter backlog for quicker failover when busy
listen "#{shared_path}/tmp/sockets/unicorn.sock", :backlog => 64
listen 8080, :tcp_nopush => true

# nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 30

working_directory "#{root_path}/current"
stderr_path       "#{shared_path}/log/error.log"
stdout_path       "#{shared_path}/log/production.log"
pid               "#{shared_path}/pids/unicorn.pid"

# combine Ruby 2.0.0dev or REE with "preload_app true" for memory savings
preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  # defined?(ActiveRecord::Base) and
  #   ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  # per-process listener ports for debugging/admin/migrations
  # addr = "127.0.0.1:#{9293 + worker.nr}"
  # server.listen(addr, :tries => -1, :delay => 5, :tcp_nopush => true)

  # the following is *required* for Rails + "preload_app true",
  # defined?(ActiveRecord::Base) and
  #   ActiveRecord::Base.establish_connection
end