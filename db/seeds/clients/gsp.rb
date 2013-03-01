# GSP accounts

puts "Creating users..."
superadmin  = User.create :email => 'superadmin@greenstatuspro.com', :password => 'abcd1234'

puts "Created:"
puts User.all.map { |u| "  #{u.email}" }

puts "Creating companies..."
gsp = Organization.create({:full_name => 'Green Status Pro, Inc.', :owner => superadmin})

puts "Associating users to companies..."
# Associate user to organization
User.find_by_email('superadmin@greenstatuspro.com').update_attribute(:organization_id, gsp.id)

