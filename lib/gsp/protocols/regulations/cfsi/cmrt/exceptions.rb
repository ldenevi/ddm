module GSP::Protocols::Regulations::CFSI::CMRT::Exceptions
  class VersionOne < StandardError
    def initialize(message = "Version 1.00 detected")
      super(message)
    end
  end
end
