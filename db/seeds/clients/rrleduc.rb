# Accounts

puts "Creating users..."
owner   = User.create :email => 'dsoroka@rrleduc.com', :password => 'abcd1234', :first_name => "Dave", :last_name => "Soroka"
sales   = User.create :email => 'eric@rrleduc.com', :password => 'abcd1234', :first_name => "Eric", :last_name => "LeDuc"
manufac = User.create :email => 'paul@rrleduc.com', :password => 'abcd1234', :first_name => "Paul", :last_name => "Blouin"

puts "Created:"
puts User.all.map { |u| "  #{u.email}" }

puts "Creating companies..."
c_main    = Organization.create(:full_name => 'R. R. LeDuc, Co.', :owner => owner)
c_sales   = Organization.create(:full_name => 'Sales', :owner => sales, :parent => c_main)
c_manufac = Organization.create(:full_name => 'Manufacturing', :owner => manufac, :parent => c_main)
c_sales_west = Organization.create(:full_name => 'West Coast Sales', :parent => c_sales, :owner => sales)
c_sales_east = Organization.create(:full_name => 'East Coast Sales', :parent => c_sales, :owner => sales)

puts "Associating users to companies..."
# Associate user to organization
User.find_by_email('dsoroka@rrleduc.com').update_attribute(:organization_id, 1)
User.find_by_email('eric@rrleduc.com').update_attribute(:organization_id, 2)
User.find_by_email('paul@rrleduc.com').update_attribute(:organization_id, 3)

puts "Purchasing all templates..."
Template.all(:select => 'id').each { |id| User.find_by_email('dsoroka@rrleduc.com').purchase_template(id) }

