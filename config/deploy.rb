set :application, 'GSP-App'

# From
set :repo_url, 'git@gitlab.greenstatuspro.com:gsp-app.git'

# To
set :deploy_to, "/var/www_rails/gsp-app"
set :deploy_via, :copy

set :scm, :git
set :branch, "master"

set :user, "capistrano"

set :ssh_options, { :forward_agent => true }
set :pty, true

set :format, :pretty
set :keep_releases, 10

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# set :deploy_to, '/var/www/my_app'
# set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

# role :db, "50.97.148.133"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  task :create_uploaded_files_symlink do
    on roles(:app) do
      execute("ln -s #{deploy_to}/shared/uploaded_files #{deploy_to}/current/public/uploaded_files")
    end
  end


  after :finishing, 'deploy:cleanup'

end

after :deploy, 'deploy:create_uploaded_files_symlink'
