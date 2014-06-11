class GSP::Documents::Converter
  class << self
    def xls_to_csv(file_path)
      GSP::Documents::Conversion::SSConvert.to_csv(file_path).worksheets
    end

    def xlsx_to_xls(file_path, output_dir_path)
      output_file_path = GSP::Documents::Conversion::OfficeConvert.to_xls(file_path, :output_dir_path => output_dir_path)
      GSP::Documents::MsOffice::Excel::Spreadsheet.new output_file_path
    end
  end
end
