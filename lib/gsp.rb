module GSP
  autoload :Client, File.join('gsp', 'client')
  autoload :Eicc, File.join('gsp', 'eicc')
  autoload :FileManager, File.join('gsp', 'file_manager')
  autoload :Reports, File.join('gsp', 'reports')
  autoload :STATUS, File.join('gsp', 'status')
  autoload :UI, File.join('gsp', 'ui')
  autoload :Users, File.join('gsp', 'users')

  VERSION = '0.4.5'
end
