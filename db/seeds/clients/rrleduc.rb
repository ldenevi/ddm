# R. R. LeDuc manufacturing http://www.rrleduc.com/
# 
# 


puts "Creating company organizations..."
c_main    = Organization.create(:full_name => 'R. R. LeDuc, Co.')
c_sales   = Organization.create(:full_name => 'Sales', :parent => c_main)
c_manufac = Organization.create(:full_name => 'Manufacturing', :parent => c_main)
# c_sales_west = Organization.create(:full_name => 'West Coast Sales', :parent => c_sales, :owner => sales)
# c_sales_east = Organization.create(:full_name => 'East Coast Sales', :parent => c_sales, :owner => sales)


# Accounts

puts "Creating users..."
owner   = User.create :email => 'dsoroka@rrleduc.com', :password => 'abcd1234', :first_name => "Dave", :last_name => "Soroka", :organization => c_main
main_exec_1 = User.create :email => 'executor1@rrleduc.com', :password => 'abcd1234', :first_name => "Executor", :last_name => "1", :organization => c_main
main_exec_2 = User.create :email => 'executor2@rrleduc.com', :password => 'abcd1234', :first_name => "Executor", :last_name => "2", :organization => c_main
main_exec_2 = User.create :email => 'executor3@rrleduc.com', :password => 'abcd1234', :first_name => "Executor", :last_name => "3", :organization => c_main
sales   = User.create :email => 'eric@rrleduc.com', :password => 'abcd1234', :first_name => "Eric", :last_name => "LeDuc", :organization => c_sales
manufac = User.create :email => 'paul@rrleduc.com', :password => 'abcd1234', :first_name => "Paul", :last_name => "Blouin", :organization => c_manufac

puts "Created:"
puts User.where("email LIKE '%@rrleduc.com'").map { |u| "  #{u.email}" }

puts "Associating organization owners..."
c_main.update_attribute(:owner, owner)
c_sales.update_attribute(:owner, sales)
c_manufac.update_attribute(:owner, manufac)


puts "Associating all LeDuc templates..."
GspTemplate.where(:full_name => "LeDuc Corporation").select(:id).each { |id| owner.purchase_template(id) }

