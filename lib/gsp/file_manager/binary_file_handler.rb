module GSP::FileManager::BinaryFileHandler
  def self.included(obj)
    obj.send(:extend, ClassMethods)
    obj.send(:attr_accessor, :data)
    obj.send(:attr_accessible, :data)
  end
  
  module ClassMethods
    @@model_extension_map ||= {}
    @@allow_undefined_format = true
    
    def accepted_extensions(*exts)
      exts.flatten! if exts.first.respond_to?(:flatten!)
      exts.each { |ext| @@model_extension_map[ext.to_sym] = self }
    end
    
    def generate(params)
      unless params.respond_to?(:keys) && params.keys.include?(:filename) && params.keys.include?(:data)
        raise InvalidParamsException.new
      end
      
      # Hack: Unless the models are loaded, we won't know which file types are supported
      Dir["./app/models/**/**"].each { |file| require file unless File.directory?(file) }
      
      supported_class = model_extension_map[extname_sym(params[:filename])]
      
      klass = (supported_class) ? supported_class.new(params) : return_self_or_exception(params)
      # klass = return_self_or_exception(params)
      klass.filename = params[:filename]
      klass.mime_types = MIME::Types.type_for(klass.filename)
      klass
    end
    
    def model_extension_map
      @@model_extension_map
    end
    
    def allow_undefined_format?
      @@allow_undefined_format
    end
    
    def accept_only_binary_file_subclasses
      @@allow_undefined_format = false
    end
    
    private
    def extname_sym(filepath)
      File.extname(filepath).sub('.', '').to_sym
    end
    
    def return_self_or_exception(params)
      if allow_undefined_format?
        self.new(params)
      else
        raise InvalidFileFormatException.new
      end
    end
  end
  
  class InvalidParamsException < ArgumentError
    attr_accessor :object
    def initialize(message = 'Parameters must include :filename and :data', object = nil)
      super(message)
      self.object = object
    end
  end
  
  class InvalidFileFormatException < TypeError
    attr_accessor :object
    def initialize(message = 'Invalid file format', object = nil)
      super(message)
      self.object = object
    end
  end
end



