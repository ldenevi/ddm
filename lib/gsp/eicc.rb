module GSP::Eicc
  autoload :Excel, File.join('gsp', 'eicc', 'excel')
  autoload :Exceptions, File.join('gsp', 'eicc', 'exceptions')
  autoload :Versions, File.join('gsp', 'eicc', 'versions')

  Rails.configuration.trial.cfsi.max_batches = 3
  Rails.configuration.trial.cfsi.max_declaration_uploads = 5
  Rails.configuration.trial.cfsi.max_suppliers = 150
end
