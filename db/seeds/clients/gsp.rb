# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Creating users..."
owner  = User.create :email => 'owner@gsp.com', :password => 'abcd1234'
sales  = User.create :email => 'sales@gsp.com', :password => 'abcd1234'
manufac = User.create :email => 'manufac@gsp.com', :password => 'abcd1234'
hr = User.create :email => 'hr@gsp.com', :password => 'abcd1234'

puts "Created:"
puts User.all.map { |u| "  #{u.email}" }

puts "Creating companies..."
companyA = Organization.create({:full_name => 'Company A', :owner => owner})
compA_HR = Organization.create({:full_name => 'CompA - Human Resources', :parent => companyA, :owner => hr})
compA_MN = Organization.create({:full_name => 'CompA - Manufacturing', :parent => companyA, :owner => manufac})
compA_SL = Organization.create({:full_name => 'CompA - Sales', :parent => companyA, :owner => sales})

compA_MN_a = Organization.create({:full_name => 'Company A - Manufacturing - Division a', :parent => compA_MN, :owner => manufac})

# Sales regions
compA_SL_NA = Organization.create({:full_name => 'Company A - Sales - North America', :parent => compA_SL, :owner => sales})
compA_SL_EU = Organization.create({:full_name => 'Company A - Sales - Europe', :parent => compA_SL, :owner => sales})
compA_SL_NA_USA = Organization.create({:full_name => 'Company A - Sales - USA', :parent => compA_SL_NA, :owner => sales})
compA_SL_NA_CAN = Organization.create({:full_name => 'Company A - Sales - Canada', :parent => compA_SL_NA, :owner => sales})
compA_SL_NA_MEX = Organization.create({:full_name => 'Company A - Sales - Mexico', :parent => compA_SL_NA, :owner => sales})


companyB = Organization.create({:full_name => 'Company B', :owner => owner})
compB_HR = Organization.create({:full_name => 'CompB - Human Resources', :parent => companyB})

puts "Associating users to companies..."
# Associate user to organization
User.find_by_email('owner@gsp.com').update_attribute(:organization_id, 1)
User.find_by_email('sales@gsp.com').update_attribute(:organization_id, 4)
User.find_by_email('manufac@gsp.com').update_attribute(:organization_id, 3)
User.find_by_email('hr@gsp.com').update_attribute(:organization_id, 2)

puts "= Purchasing templates"
User.find(1).purchase_template(1)
User.find(2).purchase_template(1)
User.find(3).purchase_template(1)
User.find(4).purchase_template(1)
