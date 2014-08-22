module GSP::Protocols::Regulations::CFSI::CMRT::Exceptions
  class VersionOne < StandardError
    def initialize(message = "Version 1.00 detected")
      super(message)
    end
  end
  class InvalidWorksheets < StandardError
    def initialize(message = "Spreadsheet does not appear to be a valid CMRT. Worksheets possibly modified.")
      super(message)
    end
  end
end
