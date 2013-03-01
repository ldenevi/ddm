# Fake company

puts "Creating users..."
admin  = User.create :email => 'admin@fake.com', :password => 'abcd1234'
owner  = User.create :email => 'owner@fake.com', :password => 'abcd1234'
executor1 = User.create :email => 'executor1@fake.com', :password => 'abcd1234'
executor2 = User.create :email => 'executor2@fake.com', :password => 'abcd1234'
fake_company_users = User.where(["email LIKE ?", '%@fake.com'])

puts "Created:"
puts fake_company_users.map { |u| "  #{u.email}" }

puts "Creating fake company..."
fake_company = Organization.create({:full_name => 'Fake, Inc.', :owner => owner})

puts "Associating users to company..."
# Associate user to organization
fake_company_users.each do |user|
  user.update_attribute(:organization_id, fake_company.id)
end

puts "= Purchasing templates"
Template.all.each do |template|
  admin.purchase_template(template.id)
  puts "  $ #{admin.eponym} bought #{template.full_name}"
end
