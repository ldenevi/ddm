require 'zip/zip'

module GSP::FileManager::Storage
  STORAGE_PATH = File.join("public", "uploaded_files")
  FileUtils.mkdir_p(STORAGE_PATH)

  def self.included(obj)
    raise MissingDataFields.new(obj) unless obj.new.respond_to?(:storage_path)
    obj.send(:include, InstanceMethods)
    obj.send(:attr_accessible, :storage_path)
    obj.send(:before_save, "self.storage_path = File.join(STORAGE_PATH, filename)")
  end

  module InstanceMethods
    def save_to_filesystem!
      File.open(storage_path, 'wb') { |f| f.write(data) }
    end

    def file_data
      File.read(storage_path)
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
