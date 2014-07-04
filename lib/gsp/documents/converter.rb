class GSP::Documents::Converter
  class << self
    def xls_to_csv(file_path)
      GSP::Documents::Conversion::SSConvert.to_csv(file_path).worksheets
    end
  end
end
