source 'http://gsp-repo1.greenstatuspro.com:8080/gems/common/'
source 'http://gsp-repo1.greenstatuspro.com:8080/gems/repo/'

gem 'rails', '3.2.13'
gem 'passenger', '4.0.27'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


# = Core Gems =
gem 'pg', '0.17.0'       # Database
gem 'i18n', '0.6.1'      # Internationalization
gem 'devise', '3.0.3'    # User authentication
gem 'rubyzip', '1.0.0'   # Zip compression
gem 'zip-zip', '0.2'     # rubyzip 1.0.0 causes LoadError 'zip/zip'
gem 'ice_cube', '0.11.1' # Scheduler
gem 'recurring_select', '1.2.0' # iCal recurrence input user interface
gem 'useragent', '0.10.0' # Detect web browser
gem 'rest-client', '1.6.7' # For GSP::Eicc::Excel::Converters::OfficeConv

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.3'
  gem 'coffee-rails', '3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', '0.5.0', :platforms => :ruby

  gem 'uglifier', '1.0.3'
end

gem 'jquery-rails', '3.0.4'
gem 'browser', '0.3.2'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# To use debugger
# gem 'debugger'

# = Development & Testing =
group :development, :test do
  gem 'rspec-rails', '2.14.0'
  gem 'cucumber', '1.3.10'
  gem 'database_cleaner', '1.2.0'

  # Deploy with Capistrano 3
  gem 'capistrano', '3.0.1'
  gem 'capistrano-rails', '1.1.0'
  gem 'capistrano-bundler', '1.1.1'

  # Web browser testing
  gem 'capybara', '2.2.0'

  # Simplify data fixturing
  gem 'factory_girl_rails', "4.0"

  # Cloud deployment
  # gem 'heroku'
end

# = Features =
# gem 'prawn'
gem 'googlecharts', '1.6.8'
gem 'axlsx', '2.0.1'
# gem 'even_calendar'
# gem 'chronic'




# = Nice-to-Have =
# gem 'nori'
# gem 'useragent'
# gem 'nokogiri'
