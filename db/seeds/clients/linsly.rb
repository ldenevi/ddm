# Linsly Industries
# 
# 


puts "Creating company organizations..."
c_main    = Organization.create(:full_name => 'Linsly Industries')

# Accounts

puts "Creating users..."
owner   = User.create :email => 'admin@linsly.com', :password => 'abcd1234', :first_name => "Scott", :last_name => "Laughlin", :organization => c_main
main_exec_1 = User.create :email => 'reviewer1@linsly.com', :password => 'abcd1234', :first_name => "Leslie", :last_name => "Munn", :organization => c_main
main_exec_2 = User.create :email => 'reviewer2@linsly.com', :password => 'abcd1234', :first_name => "Pat", :last_name => "Horn", :organization => c_main
main_exec_2 = User.create :email => 'reviewer3@linsly.com', :password => 'abcd1234', :first_name => "Chris", :last_name => "Diamond", :organization => c_main

puts "Created:"
puts User.where("email LIKE '%@linsly.com'").map { |u| "  #{u.email}" }

puts "Associating organization owners..."
c_main.update_attribute(:owner, owner)

puts "Associating templates..."
[2, 5, 3, 1, 6, 7, 8, 4].each do |id|
  owner.purchase_template(id)
end


