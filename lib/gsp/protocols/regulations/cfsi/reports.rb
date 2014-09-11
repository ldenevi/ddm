module GSP::Protocols::Regulations::CFSI::Reports
  autoload :Excel, File.join(File.dirname(__FILE__), 'reports', 'excel')
  autoload :DeclarationHelper, File.join(File.dirname(__FILE__), 'reports', 'declaration_helper')
end
