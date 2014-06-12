class GSP::Documents::Conversion::OfficeConvert
  class Excel
    XLS_972003_ADD_IN = 18
    XLS_4 = 33
    XLS_5 = 39
    CSV = 6
    OPEN_DOCUMENT_SPREADSHEET = 60

    class << self
      def to_xls_97(file_path, args = {:output_dir_path => nil})
        GSP::Documents::Conversion::OfficeConvert.convert(file_path, args, {:ms_office_app => "excel", :save_as_format_id => XLS_972003_ADD_IN})
      end

      def to_xls_4(file_path, args = {:output_dir_path => nil})
        GSP::Documents::Conversion::OfficeConvert.convert(file_path, args, {:ms_office_app => "excel", :save_as_format_id => XLS_4})
      end

      def to_xls_5(file_path, args = {:output_dir_path => nil})
        GSP::Documents::Conversion::OfficeConvert.convert(file_path, args, {:ms_office_app => "excel", :save_as_format_id => XLS_5})
      end

      def to_csv(file_path, args = {:output_dir_path => nil})
        GSP::Documents::Conversion::OfficeConvert.convert(file_path, args, {:ms_office_app => "excel", :save_as_format_id => CSV})
      end

      def to_open_document_spreadsheet(file_path, args = {:output_dir_path => nil})
        GSP::Documents::Conversion::OfficeConvert.convert(file_path, args, {:ms_office_app => "excel", :save_as_format_id => OPEN_DOCUMENT_SPREADSHEET})
      end
    end
  end
end
