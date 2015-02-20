# Set app_name to the root folder
app_name = File.basename( File.expand_path("../..", __FILE__) )

# Set environment to development unless something else is specified.
env = ENV.fetch('RAILS_ENV') { 'development' }

worker_processes ENV.fetch('WEB_WORKERS') { 4 }

# listen on both a Unix domain socket and a TCP port,
# we use a shorter backlog for quicker failover when busy
listen "/tmp/#{ app_name }.socket", backlog: 64
listen ENV.fetch('PORT') { 3000 }

# Preload our app for more specified
preload_app true

# Shut down workers after 30 seconds instead of the default 60
timeout ENV.fetch('WEB_WORKERS_TIMEOUT') { 30 }

pid "/tmp/unicorn.#{ app_name }.pid"

# Production-specific settings
if env == 'production'
#   # Help ensure your application will always spawn in the
#   # symlinked 'current' directory that Capistrano sets up
#   deploy_to = "/home/deployer/apps/staging.#{ app_name }.org"
#   working_directory "#{deploy_to}/current"

#   # feel free to point this anywhere accessible on the filesystem
#   # user 'ubuntu', 'www-data'
#   shared_path = "#{deploy_to}/shared"

#   stderr_path "#{shared_path}/log/unicorn.stderr.log"
#   stdout_path "#{shared_path}/log/unicorn.stdout.log"
end

before_fork do |server, worker|
  # the following is highly recommended for Rails + 'preload_app true'
  # as there's no need for the master process to hold a connection
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  # Before forking, kill the master process that belongs to the
  # .oldbin PID. This enables 0 downtime deploys
  old_pid = "/tmp/unicorn.#{ app_name }.pid.oldbin"

  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  # the following is *required* for Rails + 'preload_app true',
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end

  # if preload_app is true, then you may also want to check and restart
  # any other shared sockets/descriptors such as Memcached and Redis.
  # TokyoCabinet file handles are safe to reuse between any number of
  # forked children (assuming your kernel correctly implements
  # pread()/prwrite() system calls)
end