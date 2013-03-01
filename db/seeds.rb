# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

load './db/seeds/agencies.rb'
Dir['./db/seeds/templates/*'].each { |t| load t }

load "./db/seeds/clients/gsp.rb"
load "./db/seeds/clients/fake.rb"

if ENV["GSP_CLIENT"]
  load "./db/seeds/clients/#{ENV["GSP_CLIENT"]}.rb"
else
  puts "If you want to add a custome client, user GSP_CLIENT=client_name rake db:seed"
end

