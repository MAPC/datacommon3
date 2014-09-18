require 'bundler/capistrano'
require 'capistrano/ext/multistage'

set :stages, %w(staging production)
set :default_stage, 'staging'

set :application,   "datacommon.org"
set :scm,           :git 
set :repository,    "git@github.com:MAPC/datacommon3.git" 

set :migrate_target, :current 
set :ssh_options,  { forward_agent: true } 
set :rails_env,     "production"

set :normalize_asset_timestamps, false
set :assets_role,   [:app]

set :use_sudo, false 

set(:latest_release)  { fetch(:current_path) } 
set(:release_path)    { fetch(:current_path) } 
set(:current_release) { fetch(:current_path) } 

set(:current_revision)  { capture("cd #{current_path}; git rev-parse --short HEAD").strip } 
set(:latest_revision)   { capture("cd #{current_path}; git rev-parse --short HEAD").strip } 
set(:previous_revision) { capture("cd #{current_path}; git rev-parse --short HEAD@{1}").strip }




default_environment["RAILS_ENV"] = 'production'

# Use our ruby-1.1.1@dc gemset 

default_environment['PATH']         = "/usr/local/rvm/gems/ruby-2.1.1@dc/bin:/usr/local/rvm/gems/ruby-2.1.1@global/bin:/usr/local/rvm/rubies/ruby-2.1.1/bin:/usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$PATH"
default_environment['GEM_HOME']     = "/usr/local/rvm/gems/ruby-2.1.1@dc"
default_environment['GEM_PATH']     = "/usr/local/rvm/gems/ruby-2.1.1@dc:/usr/local/rvm/gems/ruby-2.1.1@global"
default_environment["RUBY_VERSION"] = "ruby-2.1.1" 

default_run_options[:shell] = 'bash'

# after 'deploy:update', 'foreman:export' # exporting doesn't presently set gid, which is needed in production
# after 'deploy:update', 'foreman:restart'


namespace :deploy do
  desc 'Deploy your application'
  task :default do
    update
    # restart
  end

  desc 'Set up your git-based deployment app'
  task :setup, except: { no_release: true } do
    dirs = [deploy_to, shared_path]
    dirs += shared_children.map { |d| File.join(shared_path, d) }
    run "#{try_sudo} mkdir -p #{dirs.join(' ')} && #{try_sudo} chmod g+w #{dirs.join(' ')}"
    run "git clone #{repository} #{current_path}"
  end

  task :cold do
    update
    migrate
  end

  task :update do
    transaction do
      update_code
    end
  end

  desc 'Update the deployed code.'
  task :update_code, except: { no_release: true } do
    run "cd #{current_path}; git fetch origin; git reset --hard #{branch}"
    finalize_update
  end

  desc "Update the database (overwritten to avoid symlink)"
  task :migrations do
    transaction do
      update_code
    end
    migrate
    restart
  end

  task :finalize_update, except: { no_release: true } do
    run "chmod -R g+w #{latest_release}" if fetch(:group_writable, true)
    run <<-CMD
       rm -rf #{latest_release}/log #{latest_release}/public/system #{latest_release}/tmp/pids && 
       mkdir -p #{latest_release}/public && 
       mkdir -p #{latest_release}/tmp && 
       ln -s #{shared_path}/log #{latest_release}/log && 
       ln -s #{shared_path}/system #{latest_release}/public/system && 
       ln -s #{shared_path}/pids #{latest_release}/tmp/pids && 
       ln -sf #{shared_path}/config/database.yml #{latest_release}/config/database.yml
    CMD

    # precompile the assets
    # run "cd #{latest_release}; bundle exec rake assets:precompile"

    if fetch(:normalize_asset_timestamps, true)
      stamp = Time.now.utc.strftime("%Y%m%d%H%M.%S")
      asset_paths = fetch(:public_children, %w(images stylesheets javascripts)).map { |p| "#{latest_release}/public/#{p}" }.join(" ")
      run "find #{asset_paths} -exec touch -t #{stamp} {} ';'; true", env: { "TZ" => "UTC" }
    end
  end

  desc "Zero-downtime restart of Unicorn"
  task :restart, except: { no_release: true } do
    begin
      run "kill -s USR2 `cat /tmp/unicorn.datacommon.pid`"
    rescue
      # It wasn't running. No problem.
    end
  end

  desc "Start Unicorn"
  task :start, except: { no_release: true } do
    run "cd #{current_path} ; bundle exec unicorn_rails -c config/unicorn.rb -D"
  end

  desc "Stop Unicorn"
  task :stop, except: { no_release: true } do
    run "kill -s QUIT `cat /tmp/unicorn.datacommon.pid`"
  end

  namespace :rollback do

    desc "Moves the repo back to the previous version of HEAD"
    task :repo, except: { no_release: true } do
      set :branch, "HEAD@{1}"
      deploy.default
    end

    desc "Rewrite reflog so HEAD@{1} will continue to point to the previous release"
    task :cleanup, except: { no_release: true } do
      run "cd #{current_path}; git reflog delete --rewrite HEAD@{1}; git reflog delete --rewrite HEAD@{1}"
    end

    desc "Rolls back to the previously deployed version"
    task :default do
      rollback.repo
      rollback.cleanup
    end
  end
end

namespace :foreman do
  desc "Export the Procfile and environments to Ubuntu's upstart scripts"
  task :export, roles: :app do
    run "cd #{current_path} && #{try_sudo} bundle exec foreman export -e .env upstart /etc/init -a #{application} -u #{user} -l #{shared_path}/log --procfile=Procfile.#{stage}"
  end

  desc "Start the application services"
  task :start, roles: :app do
    sudo "start #{application}"
  end

  desc "Stop the application services"
  task :stop, roles: :app do
    sudo "stop #{application}"
  end

  desc "Restart the application services"
  task :restart, roles: :app do
    run "sudo start #{application} || sudo restart #{application}"
  end
end


namespace :db do
  desc "Migrate the database"
  task :migrate do
    run "cd #{current_path} %% #{try_sudo} bundle exec rake db:migrate"
  end

  desc "Seed the database"
  task :seed do
    run "cd #{current_path} %% #{try_sudo} bundle exec rake db:seed"
  end
end

namespace :rails do
  desc "Run the rails console"
  task :c do
    run "cd #{current_path} %% #{try_sudo} bundle exec rails console"
  end
end


def run_rake(cmd)
  run "cd #{current_path}; #{rake} #{cmd}"
end