# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

load './db/seeds/agencies.rb'
Dir['./db/seeds/templates/*.rb'].each { |t| load t }

load "./db/seeds/clients/gsp.rb"
load "./db/seeds/clients/springfield.rb"
load "./db/seeds/clients/cohasset.rb"
load "./db/seeds/clients/linsly.rb"

if ENV["GSP_CLIENT"]
  Dir["./db/seeds/templates/#{ENV['GSP_CLIENT']}/*.rb"].each { |t| load t }
  load "./db/seeds/clients/#{ENV["GSP_CLIENT"]}.rb"
else
  puts "If you want to add a custom client, use GSP_CLIENT=client_name rake db:seed"
end

