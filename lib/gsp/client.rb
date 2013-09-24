module GSP
  class Client
  
    class << self
      def new      
        company = {}
        admin   = {}
        ids     = []

        puts "\n\n\n\n"
        # Enter company details
        begin
          printf "\nEnter company name: "
          
          company[:full_name] = gets
          company[:full_name] = company[:full_name].strip
          
          printf "Is this correct '#{company[:full_name]}' (y/n)? "
        end while (wait_for_yes)  
        
        
        puts "\n"
        # Enter admin
        begin
          puts "\nCreate the Admin User for '#{company[:full_name]}'"
          
          printf "Enter first name: "; admin[:first_name] = gets.strip
          printf "Enter last name: ";  admin[:last_name]  = gets.strip
          printf "Enter e-mail: ";     admin[:email]      = gets.strip
          
          puts "\nVerify Admin attributes:"
          puts "First name:   #{admin[:first_name]}"
          puts "Last name:    #{admin[:last_name]}"
          puts "E-Mail/Login: #{admin[:email]}"
          printf "Is this correct (y/n)? "
        end while (wait_for_yes)
        puts   "Password will be 'abcd1234' for '#{admin[:email]}'\n\n"
        admin[:password] = 'abcd1234'
        
        templates = GspTemplate.all
        
        puts "\n\n\n"
        begin
          puts "Enter ids for the templates to purchase for '#{company[:full_name]}'. Separate ids by commas (e.g. 4, 13, 11, 76)\n"
          puts " id: name"
          templates.each do |t|
            puts t.id.to_s.rjust(3, ' ') + ": " + t.regulatory_review_name
          end
          
          printf "\nEnter ids: "; ids = gets.split(',').map(&:strip).map(&:to_i)
          
          puts "Add the following templates to the library of '#{company[:full_name]}':"
          puts ids
          printf "Is this correct (y/n)?"
        end while (wait_for_yes)
        puts "\n\n"
        
        # Create data
        puts "Creating #{company[:full_name]} company..."
        org = Organization.create(company)
        
        puts "Creating admin #{admin[:email]}..."
        user = User.create(admin.merge({:organization => org}))
        
        puts "Associating company owner..."
        org.update_attribute(:owner, user)
        
        puts "Purchasing templates"
        GspTemplate.find(ids).each do |template|
          puts "  $ #{user.eponym} bought #{template.regulatory_review_name}"
          user.purchase_template(template)
        end
        
        
        puts "\n\n\n"
        puts "Login into dev1.greenstatuspro.com and log in as:"
        puts "username: #{user.email}"
        puts "password: abcd1234"
        
        return true
        
      end
      
      
      
      def wait_for_yes
        gets.split('').first.downcase != 'y'
      end
      
    end # end : class << self
     
  end

end
