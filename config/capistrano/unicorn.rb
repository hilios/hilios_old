# Unicorn tasks
namespace :unicorn do
  def pid_path
    "#{shared_path}/pids/unicorn.pid"
  end

  def socket_path
    "#{shared_path}/sockets/unicorn.sock"
  end

  def check_pid_path_then_run(command)
    run <<-CMD
      if [ -s #{pid_path} ]; then
        #{command}
      else
        echo "Unicorn master worker wasn't found, possibly wasn't started at all. Try run unicorn:start first";
      fi
    CMD
  end

  desc "Starts the Unicorn server"
  task :start do
    run "mkdir -p #{File.dirname(pid_path)}"
    run "mkdir -p #{File.dirname(socket_path)}"
    run <<-CMD
      if [ ! -s #{pid_path} ]; then
        cd #{current_path} ; bundle exec unicorn -c #{current_path}/config/unicorn.rb -D -E production;
      else
        echo "Unicorn is already running at PID: `cat #{pid_path}`";
      fi
    CMD
  end

  desc "Stops Unicorn server"
  task :stop do
    check_pid_path_then_run "kill -s QUIT `cat #{pid_path}`;"
  end

  desc "Zero-downtime restart of Unicorn"
  task :restart, :roles => :app, :except => { :no_release => true } do
    check_pid_path_then_run "kill -USR2 `cat #{pid_path}`;"
  end
end