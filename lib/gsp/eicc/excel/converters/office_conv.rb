module GSP::Eicc::Excel::Converters::OfficeConv
  require 'rest_client'

  class Convert
    class << self
      def to_xls(filepath, args = {:output_dirpath => nil})
        file = File.new(filepath)
        params = {:ms_office_app=>"excel", :save_as_format_id=>39, :input_file=>file}
        response = RestClient.post "http://officeconv.greenstatuspro.com:3000/conversions/convert", params
        xls_filename = response.headers[:content_disposition].split(';')[1].split('=')[1].gsub('"','')
        FileUtils.mkdir_p(args[:output_dirpath])
        converted_filepath = File.join(args[:output_dirpath], xls_filename)
        File.open(converted_filepath, 'wb') { |f| f.write(response) }
        converted_filepath
      end
    end
  end
end
