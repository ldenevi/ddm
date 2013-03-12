require 'zip/zip'

module GSP::FileManager::Storage
  STORAGE_PATH = File.join("public", "uploaded_files")
  FileUtils.mkdir_p(STORAGE_PATH)

  def self.included(obj)
    raise MissingDataFields.new(obj) unless obj.new.respond_to?(:storage_path)
    obj.send(:include, InstanceMethods)
    obj.send(:attr_accessible, :storage_path)
  end
  
  module InstanceMethods
    def initialize(args = {})
      super(args.merge({:storage_path => File.join(STORAGE_PATH, "#{rand(100000..999999999)}.gsp")}))
    end
    
    def save_to_filesystem!
      puts storage_path
      File.open(storage_path, 'wb') { |f| f.write(data) }
    end
  end
  
  class MissingDataFields < StandardError
    attr_accessor :object
    def initialize(object = nil)
      super("Model '#{object}' missing fields: storage_path'")
      self.object = object
    end
  end
end   
