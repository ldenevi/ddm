require 'csv'

class GSP::Documents::MsOffice::Excel::Spreadsheet
  attr_accessor :file_name, :file_path

  def initialize(file_path)
    self.file_name = File.basename(file_path)
    self.file_path = file_path
  end

  def to_s
    {:@file_name => @file_name, :@file_path => @file_path}
  end

  class Worksheet
    attr_accessor :file_name, :file_path, :data, :csv

    def initialize(args = {:data => nil, :file_name => nil, :file_path => nil, :csv => nil})
      self.data = args[:data]
      self.file_name = args[:file_name]
      self.file_path = args[:file_path]
      self.csv = args[:csv]
    end

    def self.load_csv(file_path)
      file = File.open(file_path, "r:ascii-8bit")
      data = file.read
      worksheet = new :data => data,
                 :file_name => File.basename(file_path),
                 :file_path => file_path,
                 :csv => CSV.new(data)
      file.close
      worksheet
    end

    def self.load_string(data, args = {:file_name => nil, :file_path => nil})
      new :data => data,
           :file_name => args[:file_name],
           :file_path => args[:file_path],
           :csv => CSV.new(data)
    end

    def to_s
      {:@file_name => @file_name, :@data => "#{@data[0..48]} ...", :@csv => @csv.inspect}
    end
  end
end
