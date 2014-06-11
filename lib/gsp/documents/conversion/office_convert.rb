require 'rest_client'
class GSP::Documents::Conversion::OfficeConvert
  class << self
    def to_xls(file_path, args = {:output_dir_path => nil})
      file = File.new(file_path)
      params = {:ms_office_app=>"excel", :save_as_format_id=>18, :input_file=>file}
      response = RestClient.post "http://officeconv.greenstatuspro.com:3000/conversions/convert", params
      xls_file_name = response.headers[:content_disposition].split(';')[1].split('=')[1].gsub('"','')
      FileUtils.mkdir_p(args[:output_dir_path])
      converted_file_path = File.join(args[:output_dir_path], xls_file_name)
      File.open(converted_file_path, 'wb') { |f| f.write(response) }
      converted_file_path
    end
  end
end
