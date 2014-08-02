module GSP::Protocols::Regulations::CFSI::CMRT::Maps
  autoload :Version2Dot00, File.join('gsp', 'protocols', 'regulations', 'cfsi', 'cmrt', 'maps', 'version_2.00')
  autoload :Version2Dot01, File.join('gsp', 'protocols', 'regulations', 'cfsi', 'cmrt', 'maps', 'version_2.01')
  autoload :Version2Dot02, File.join('gsp', 'protocols', 'regulations', 'cfsi', 'cmrt', 'maps', 'version_2.02')
  autoload :Version2Dot03, File.join('gsp', 'protocols', 'regulations', 'cfsi', 'cmrt', 'maps', 'version_2.03')
  autoload :Version2Dot03a, File.join('gsp', 'protocols', 'regulations', 'cfsi', 'cmrt', 'maps', 'version_2.03a')
  autoload :Version3Dot00, File.join('gsp', 'protocols', 'regulations', 'cfsi', 'cmrt', 'maps', 'version_3.00')
  autoload :Version3Dot01, File.join('gsp', 'protocols', 'regulations', 'cfsi', 'cmrt', 'maps', 'version_3.01')

  def self.included(obj)
    obj.send(:include, InstanceMethods)
  end

  module InstanceMethods
    def get_structure_for_version(val)
      eval("GSP::Protocols::Regulations::CFSI::CMRT::Maps::Version#{val.gsub('.', 'Dot')}.structure")
    end

    def get_cell_definitions_for_version(val)
      eval("GSP::Protocols::Regulations::CFSI::CMRT::Maps::Version#{val.gsub('.', 'Dot')}.cell_definitions")
    end
  end
end
