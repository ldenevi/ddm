# AU Electronics company

puts "Creating AU Electronics company..."
au_company = Organization.create({:full_name => 'AU Electronics'})

puts "Creating users..."
admin  = User.create :email => 'admin@au.com', :password => 'abcd1234', :first_name => 'Leo', :last_name => 'Hancock', :organization => au_company
owner  = User.create :email => 'owner@au.com', :password => 'abcd1234', :first_name => 'Laura', :last_name => "Bruce", :organization => au_company
reviewer1 = User.create :email => 'reviewer1@au.com', :password => 'abcd1234', :first_name => 'Larry', :last_name => 'Connor', :organization => au_company
au_company_users = User.where(["email LIKE ?", '%@au.com'])

puts "Created:"
puts au_company_users.map { |u| "  #{u.email}" }

puts "Associating company owner..."
au_company.update_attribute(:owner, admin)

puts "= Purchasing templates"
GspTemplate.all.each do |template|
  admin.purchase_template(template.id)
  puts "  $ #{admin.eponym} bought #{template.full_name}"
end
