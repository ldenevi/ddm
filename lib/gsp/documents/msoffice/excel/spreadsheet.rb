require 'csv'

class GSP::Documents::MsOffice::Excel::Spreadsheet
  class Worksheet
    attr_accessor :file_name, :file_path, :data, :csv

    def initialize(args = {:data => nil, :file_name => nil, :file_path => nil, :csv => nil})
      self.data = args[:data]
      self.file_name = args[:file_name]
      self.file_path = args[:file_path]
      self.csv = args[:csv]
    end

    def self.load_csv(file_path)
      data = File.read(file_path)
      new :data => data,
           :file_name => File.basename(file_path),
           :file_path => file_path,
           :csv => CSV.new(data)
    end

    def to_s
      {:@file_name => @file_name, :@data => "#{@data[0..48]} ...", :@csv => @csv.inspect}
    end
  end
end
