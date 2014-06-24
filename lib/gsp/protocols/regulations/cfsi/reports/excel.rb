module GSP::Protocols::Regulations::CFSI::Reports::Excel
  autoload :Report, File.join(File.dirname(__FILE__), 'excel', 'report')
  autoload :AggregatedDeclarations, File.join(File.dirname(__FILE__), 'excel', 'aggregated_declarations')
  autoload :ConsolidatedSmelters, File.join(File.dirname(__FILE__), 'excel', 'consolidated_smelters')
end
