module GSP::Protocols::Regulations::CFSI::Reports::Excel
  autoload :Report, File.join(File.dirname(__FILE__), 'excel', 'report')
  autoload :ConsolidatedSmelters, File.join(File.dirname(__FILE__), 'excel', 'consolidated_smelters')
end
