require 'digest/md5'

class GSP::Documents::Conversion::SSConvert
  autoload :Exceptions, File.join('gsp', 'documents', 'conversion', 'ssconvert', 'exceptions')

  COMMAND = "ssconvert -S '%s' '%s' 2>&1"

  # Output messages
  attr_accessor :raw_output
  attr_accessor :outputs
  attr_accessor :exporter
  attr_accessor :errors

  # Files in and out
  attr_accessor :spreadsheet_file_path
  attr_accessor :spreadsheet_file_name
  attr_accessor :output_directory_path

  # Each worksheet output in order
  attr_accessor :worksheets

  def self.is_ssconvert_installed?
    system("which ssconvert")
  end

  def self.to_csv(file_path, args = {:skip_convert => false, :delete_output_files => true})
    obj = new file_path
    obj.convert('csv', :delete_output_files => args[:delete_output_files]) unless args[:skip_convert]
    obj
  end

  def initialize(file_path = nil)
    raise ArgumentError, "no Excel file path given" if file_path.nil?
    @output_directory_path = File.join('tmp', 'gsp', 'cfsi', 'spreadsheet_conversions', Digest::MD5.hexdigest(Time.now.to_s + file_path))
    @spreadsheet_file_path = file_path
    @spreadsheet_file_name = File.basename(file_path)
    @worksheets            = []
  end

  require 'fileutils'
  def convert(output_ext, args = {:delete_output_files => true})
    secure_spreadsheet_file_path = spreadsheet_file_path # TODO strip non white-listed patterns
    file_name_sans_ext = File.basename(secure_spreadsheet_file_path).gsub(File.extname(secure_spreadsheet_file_path), '')
    command = COMMAND % [spreadsheet_file_path, File.join(output_directory_path, "#{file_name_sans_ext}.#{output_ext}")]

    # Run COMMAND
    FileUtils.mkdir_p(self.output_directory_path)
    self.raw_output = eval("`#{command}`")

    self.outputs    = self.raw_output.to_s.split("\n")
    self.exporter   = self.outputs.first
    self.errors     = self.outputs.select { |a| a.gsub(/^E /, "") if a.match(/^E /) }

    begin
      # Scan the errors outputted by sscovert
      self.errors.each do |error|
        raise Exceptions::NoOutputDestinationFound, error     if error.match(/Can\'t open .+ for writing.+/)
        raise Exceptions::FileNotFound, self.spreadsheet_file_path  if error.match(/No such file or directory$/) && error.match(/Can\'t open .+ for writing.+/).nil?
        raise Exceptions::CannotReadFile, self.spreadsheet_file_name if error.match(/Unsupported file format/)
      end

      # TODO Generalize this section for other formats
      # There should be a set of CSV files outputted
      raise Exceptions::NoOutput, "Could not find any CSV file in #{self.output_directory_path}" if Dir.glob(File.join(self.output_directory_path, "*.csv.*")).empty?

      output_files = Dir.glob(File.join(self.output_directory_path, "*.csv.*")).sort { |a,b| a.split('.').last.to_i <=> b.split('.').last.to_i }
      output_files.each do |path|
        self.worksheets << GSP::Documents::MsOffice::Excel::Spreadsheet::Worksheet.load_csv(path)
      end
      # ENDTODO
    ensure
      FileUtils.rm_r(self.output_directory_path) if args[:delete_output_files]
    end
    output_files
  end

  def to_s
    attributes = {}
    self.instance_variables.each { |name| attributes[name] = eval("#{name}") }
    attributes
  end


end
