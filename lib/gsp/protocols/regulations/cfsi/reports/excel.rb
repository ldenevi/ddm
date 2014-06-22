module GSP::Protocols::Regulations::CFSI::Reports::Excel
  autoload :Report, File.join(File.dirname(__FILE__), 'excel', 'report')
  autoload :AggregatedSmelters, File.join(File.dirname(__FILE__), 'excel', 'aggregated_smelters')
  autoload :ConsolidatedSmelters, File.join(File.dirname(__FILE__), 'excel', 'consolidated_smelters')
end
