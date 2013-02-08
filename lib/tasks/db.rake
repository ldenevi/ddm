namespace :db do
  desc "WARNING! Drops, rebuilds, seeds entire database"
  task :total_reset => :environment do
    # rake db:migrate VERSION=0 ;rake db:migrate; rake db:seed
    system('rake db:drop; rake db:create; rake db:migrate; rake db:seed')
  end

end
