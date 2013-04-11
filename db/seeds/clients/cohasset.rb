# Cohasset Instruments Inc.
# 
# 


puts "Creating Cohasset Instruments Inc. organizations..."
c_main    = Organization.create(:full_name => 'Cohasset Instruments Inc.')
c_sales   = Organization.create(:full_name => 'Sales', :parent => c_main)
c_manufac = Organization.create(:full_name => 'Manufacturing', :parent => c_main)
c_sales_west = Organization.create(:full_name => 'West Coast Sales', :parent => c_sales)
c_sales_east = Organization.create(:full_name => 'East Coast Sales', :parent => c_sales)


puts "Creating users..."
admin  = User.create :email => 'admin@cohasset.com', :password => 'abcd1234', :first_name => 'David', :last_name => 'Bitzer', :organization => c_main
owner  = User.create :email => 'owner@cohasset.com', :password => 'abcd1234', :first_name => 'Donna', :last_name => 'Jojorian', :organization => c_main
exec1  = User.create :email => 'derek@cohasset.com', :password => 'abcd1234', :first_name => 'Derek', :last_name => 'Harty', :organization => c_main

c_main_users = User.where(["email LIKE ?", '%@cohasset.com'])

puts "Created:"
puts c_main_users.map { |u| "  #{u.email}" }

puts "Associating company owner..."
c_main.update_attribute(:owner, admin)

puts "= Purchasing templates"
GspTemplate.all.each do |template|
  admin.purchase_template(template.id)
  puts "  $ #{admin.eponym} bought #{template.full_name}"
end
