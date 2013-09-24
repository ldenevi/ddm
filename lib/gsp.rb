module GSP
  autoload :Client, File.join('gsp', 'client')
  autoload :FileManager, File.join('gsp', 'file_manager')
  autoload :STATUS, File.join('gsp', 'status')
  autoload :UI, File.join('gsp', 'ui')
  autoload :Users, File.join('gsp', 'users')
  
  VERSION = '0.3.2 Beta'
end
