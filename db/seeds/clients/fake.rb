# Fake company

puts "Creating fake company..."
fake_company = Organization.create({:full_name => 'Fake, Inc.'})

puts "Creating users..."
admin  = User.create :email => 'admin@fake.com', :password => 'abcd1234', :organization => fake_company
owner  = User.create :email => 'owner@fake.com', :password => 'abcd1234', :organization => fake_company
executor1 = User.create :email => 'executor1@fake.com', :password => 'abcd1234', :organization => fake_company
executor2 = User.create :email => 'executor2@fake.com', :password => 'abcd1234', :organization => fake_company
fake_company_users = User.where(["email LIKE ?", '%@fake.com'])

puts "Created:"
puts fake_company_users.map { |u| "  #{u.email}" }

puts "Associating company owner..."
fake_company.update_attribute(:owner, admin)

puts "= Purchasing templates"
GspTemplate.all.each do |template|
  admin.purchase_template(template.id)
  puts "  $ #{admin.eponym} bought #{template.full_name}"
end
