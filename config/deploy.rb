require 'bundler/capistrano'

set :application, "GSP App"
set :repository,  "ssh://git@gitlab.greenstatuspro.com:gsp-app.git"

set :scm, :git
set :branch, "master"

set :user, "capistrano"
set :user_sudo, false

set :ssh_options, { :forward_agent => true }
default_run_options[:pty] = true


# Servers
set :gsp_app1, "50.97.148.131"
set :gsp_db1, "50.97.148.133"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, gsp_app1                      # Your HTTP server, Apache/etc
role :app, gsp_app1                      # This may be the same as your `Web` server
# role :db,  gsp_db1, :primary => true     # This is where Rails migrations will run
# role :db,  "your slave db-server here"

set :rails_env, :production

set :deploy_to, "/var/www_rails/gsp-app"
set :deploy_via, :export

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :db do
  task :migrate, :roles => :app do
    puts "Sending identify commands"
    run "uname -a & ls -l & whoami"
  end
end

namespace :log do
  task :show, :roles => :app do
    run "tail -n100 #{deploy_to}/current/log/production.log"
  end
end

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
