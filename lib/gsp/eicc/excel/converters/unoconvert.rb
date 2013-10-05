module GSP::Eicc::Excel::Converters::UnoConvert
  require 'fileutils'
  class UnoConvert
    attr_reader :xlsx_file_path, :xls_file_path, :output_directory, :raw_output
    
    def self.xlsx_to_xls(file_path, args = {:output_directory => '.'})
      command = "unoconv --doctype=spreadsheet --verbose --format=xls --outputpath='%s' '%s' 2>&1" % [args[:output_directory], file_path]
      puts command
      raw_output = eval("`#{command}`")
      
      FileUtils.mkdir_p(args[:output_directory])
      
      new :xlsx_file_path => file_path, 
           :xls_file_path => Dir.glob(File.join(args[:output_directory], "*.xls")),
           :output_directory => args[:output_directory],
           :raw_output => raw_output
    end
    
    def initialize(args = {:xlsx_file_path => nil, :xls_file_path => nil, :output_directory => nil, :raw_output => nil})
      @xlsx_file_path = args[:xlsx_file_path]
      @xls_file_path  = args[:xls_file_path]
      @output_directory = args[:output_directory]
      @raw_output = args[:raw_output]
    end
    
    def to_s
      {:@xlsx_file_path => @xlsx_file_path, :@xls_file_path => @xls_file_path, :@output_directory => @output_directory, :@raw_output => @raw_output}
    end
  end
end
