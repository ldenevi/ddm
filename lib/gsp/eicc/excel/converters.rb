module GSP::Eicc::Excel::Converters
  autoload :Gnumeric, File.join('gsp', 'eicc', 'excel', 'converters', 'gnumeric')
  autoload :UnoConvert, File.join('gsp', 'eicc', 'excel', 'converters', 'unoconvert')
  autoload :OfficeConv, File.join('gsp', 'eicc', 'excel', 'converters', 'office_conv')
end
