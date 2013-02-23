# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

load './db/seeds/agencies.rb'
Dir['./db/seeds/templates/*'].each { |t| load t }

if ENV["GSP_CLIENT"]
  load "./db/seeds/clients/#{ENV["GSP_CLIENT"]}.rb"
else
  load "./db/seeds/clients/gsp.rb"
end

