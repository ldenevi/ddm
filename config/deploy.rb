require 'bundler/capistrano'

set :application, "GSP App"
set :repository,  "git@gitlab.greenstatuspro.com:gsp-app.git"

set :scm, :git
set :branch, "master"

set :user, "capistrano"
set :user_sudo, false

set :ssh_options, { :forward_agent => true }
default_run_options[:pty] = true


# Menu options for targeted machines
unless fetch(:stage, nil)
  set :stage do
    Capistrano::CLI.ui.choose do |menu|
      menu.header = "Deploy to which server?"
      menu.choice = "staging"
      menu.choice = "production"
      menu.prompt = "Server: "
    end
  end
end

set :rails_env, :stage
set :database_ip, "50.97.148.133"

case rails_env
  when "staging"
    role :web, "75.126.142.146"
    role :app, "75.126.142.146"
    role :db, database_ip
  when "production"
    role :web, "50.97.148.131"
    role :app, "50.97.148.131"
    role :db, database_ip
end


set :deploy_to, "/var/www_rails/gsp-app"
set :deploy_via, :export

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :create_uploaded_files_symlink, :roles => :app do
    run "ln -s #{deploy_to}/shared/uploaded_files #{deploy_to}/current/public/uploaded_files"
  end
end

after "deploy", "deploy:create_uploaded_files_symlink"

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
