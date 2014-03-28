# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'revive2'
set :repo_url, 'git@github.com:zitsel/supero.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
 set :deploy_to, '/usr/local/www/revive'
 set :branch, 'master'
# Default value for :scm is :git
 set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, "production" 

# Default value for keep_releases is 5
# set :keep_releases, e

namespace :deploy do
  task :setup_config do
  sudo "ln -nfs /usr/local/share/database.yml #{release_path}/config/database.yml"
  sudo "ln -nfs /usr/local/share/config.yml #{release_path}/config/config.yml"    
  end
after "deploy:finalize_update", "deploy:symlink_config"

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
