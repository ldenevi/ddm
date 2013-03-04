# GSP accounts

puts "Creating companies..."
gsp = Organization.create({:full_name => 'Green Status Pro, Inc.'})

puts "Creating users..."
superadmin  = User.create :email => 'superadmin@greenstatuspro.com', :password => 'abcd1234', :organization => gsp

puts "Created:"
puts User.all.map { |u| "  #{u.email}" }


puts "Associating users to companies..."
# Associate user to organization
gsp.update_attribute(:owner_id, superadmin.id)

puts "Purchasing all templates..."
GspTemplate.all.each { |template| superadmin.purchase_template(template.id) }
