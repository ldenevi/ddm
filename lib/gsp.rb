class Hash
  # https://github.com/rest-client/rest-client/issues/141
  remove_method :read
end

module GSP
  autoload :Client, File.join('gsp', 'client')
  autoload :Eicc, File.join('gsp', 'eicc')
  autoload :FileManager, File.join('gsp', 'file_manager')
  autoload :Reports, File.join('gsp', 'reports')
  autoload :STATUS, File.join('gsp', 'status')
  autoload :UI, File.join('gsp', 'ui')
  autoload :Users, File.join('gsp', 'users')

  VERSION = '0.4.508'

  class Application < Rails::Application
    include GSP::STATUS

    require 'csv'

    # Conflict-Free Sourcing Initiative
    config.cfsi = ActiveSupport::OrderedOptions.new
    config.cfsi.conflict_minerals = ["Gold", "Tin", "Tungsten", "Tantalum"]
    config.cfsi.countries = CSV.open("config/gsp/countries.en.csv").to_a.flatten.uniq
  end
end
