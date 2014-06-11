module GSP::Eicc::Excel::Converters::Gnumeric
  autoload :Exceptions, File.join('gsp', 'eicc', 'excel', 'converters', 'gnumeric', 'exceptions')

  require 'digest/md5'

  class Gnumeric
    COMMAND = "ssconvert -S '%s' '%s' 2>&1"
    # Output messages
    attr_accessor :raw_output
    attr_accessor :outputs
    attr_accessor :exporter
    attr_accessor :errors

    # Files in and out
    attr_accessor :excel_file_path
    attr_accessor :excel_filename
    attr_accessor :csv_output_directory_path

    # Each CSV output in order
    attr_accessor :worksheets

    def initialize(file_path = nil, args = {:skip_convert => false, :delete_output_files => false})
      raise ArgumentError, "no Excel file path given" if file_path.nil?

      @csv_output_directory_path = File.join('tmp', 'gsp', 'eicc', 'excel_conversions', Digest::MD5.hexdigest(Time.now.to_s + file_path))

      # If it's an .xlsx file, convert it to .xls first
      # unless File.extname(file_path) == ".xls"
        file_path = GSP::Eicc::Excel::Converters::OfficeConv::Convert.to_xls(file_path, :output_dirpath => @csv_output_directory_path)
      # end

      @excel_file_path = file_path
      @excel_filename  = File.basename(file_path)
      @worksheets      = []
      convert(args[:delete_output_files]) unless args[:skip_convert]
    end

    require 'fileutils'
    def convert(delete_output_files)
      secure_excel_file_path = excel_file_path # TODO strip non white-listed patterns
      command = COMMAND % [excel_file_path, File.join(csv_output_directory_path, 'eicc.csv')]

      # Run COMMAND
      FileUtils.mkdir_p(self.csv_output_directory_path)
      self.raw_output = eval("`#{command}`")

      self.outputs    = self.raw_output.to_s.split("\n")
      self.exporter   = self.outputs.first
      self.errors     = self.outputs.select { |a| a.gsub(/^E /, "") if a.match(/^E /) }

      # Scan the errors outputted by sscovert
      self.errors.each do |error|
        raise Exceptions::NoOutputDestinationFound, error     if error.match(/Can\'t open .+ for writing.+/)
        raise Exceptions::FileNotFound, self.excel_file_path  if error.match(/No such file or directory$/) && error.match(/Can\'t open .+ for writing.+/).nil?
        raise Exceptions::CannotReadFile, self.excel_filename if error.match(/Unsupported file format/)
      end

      # There should be a set of CSV files outputted
      raise Exceptions::NoOutput, "Could not find any CSV file in #{self.csv_output_directory_path}" if Dir.glob(File.join(self.csv_output_directory_path, "*.csv.*")).empty?

      output_files = Dir.glob(File.join(self.csv_output_directory_path, "*.csv.*")).sort { |a,b| a.split('.').last.to_i <=> b.split('.').last.to_i }
      output_files.each do |path|
        self.worksheets << Worksheet.new(path)
      end

      FileUtils.rm_r(self.csv_output_directory_path) if delete_output_files
      output_files
    end

    def to_s
      attributes = {}
      self.instance_variables.each { |name| attributes[name] = eval("#{name}") }
      attributes
    end

  end

  require 'csv'
  class Worksheet
    attr_accessor :filename, :file_path, :data, :csv

    def initialize(file_path)
      @data = File.read(file_path)
      @filename = File.basename(file_path)
      @file_path = file_path
      @csv = CSV.new(data)
    end

    def to_s
      {:@filename => @filename, :@data => "#{@data[0..48]} ...", :@csv => @csv.inspect}
    end
  end
end
