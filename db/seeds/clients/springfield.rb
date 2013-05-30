# springfield company

puts "Creating Springfield Co. company..."
springfield_company = Organization.create({:full_name => 'Springfield, Co.'})

puts "Creating users..."
admin  = User.create :email => 'admin@springfield.com', :password => 'abcd1234', :first_name => 'Aaron', :last_name => 'Allgemein', :organization => springfield_company
owner  = User.create :email => 'owner@springfield.com', :password => 'abcd1234', :first_name => 'Oscar', :last_name => "O'Brien", :organization => springfield_company
reviewer1 = User.create :email => 'reviewer1@springfield.com', :password => 'abcd1234', :first_name => 'Bruce', :last_name => 'Banner', :organization => springfield_company
reviewer2 = User.create :email => 'reviewer2@springfield.com', :password => 'abcd1234', :first_name => 'Charles', :last_name => 'Custard', :organization => springfield_company
reviewer3 = User.create :email => 'reviewer3@springfield.com', :password => 'abcd1234', :first_name => 'Daniel', :last_name => 'Damico', :organization => springfield_company
springfield_company_users = User.where(["email LIKE ?", '%@springfield.com'])

puts "Created:"
puts springfield_company_users.map { |u| "  #{u.email}" }

puts "Associating company owner..."
springfield_company.update_attribute(:owner, admin)

puts "= Purchasing templates"
GspTemplate.all.each do |template|
  admin.purchase_template(template.id)
  puts "  $ #{admin.eponym} bought #{template.full_name}"
end
