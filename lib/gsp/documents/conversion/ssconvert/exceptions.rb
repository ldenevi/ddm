module GSP::Documents::Conversion::SSConvert::Exceptions
  class FileNotFound < StandardError
    def initialize(file_path)
      super("File '%s' not found on system" % file_path)
    end
  end

  class CannotReadFile < StandardError
    def initialize(filename)
      super("Could not open file '%s' for conversion" % filename)
    end
  end

  class NoOutputDestinationFound < StandardError
    def initialize(gnumeric_error)
      super(gnumeric_error)
    end
  end

  class NoOutput < StandardError
    def initialize(message = "No files outputted")
      super(message)
    end
  end

  class InvalidDeclarationForm < StandardError
    def initialize(message = "File is not a valid declaration form")
      super(message)
    end
  end
end
