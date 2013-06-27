# Intel company

puts "Creating Intel company..."
company = Organization.create({:full_name => 'Intel (GSP)'})

puts "Creating users..."
admin  = User.create :email => 'bryan.fiereck@gspbeta31.com', :password => 'abcd1234', :first_name => 'Bryan', :last_name => 'Fiereck', :organization => company
company_users = User.where(["email LIKE ?", '%@gspbeta31.com'])

puts "Created:"
puts company_users.map { |u| "  #{u.email}" }

puts "Associating company owner..."
company.update_attribute(:owner, admin)

puts "= Purchasing templates"
GspTemplate.find([22,23,24,25,26]).each do |template|
  admin.purchase_template(template)
  puts "  $ #{admin.eponym} bought #{template.full_name}"
end
