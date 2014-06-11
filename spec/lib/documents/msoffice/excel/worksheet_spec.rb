require 'spec_helper'

describe GSP::Documents::MsOffice::Excel::Spreadsheet::Worksheet do
  SAMPLE_DATA_PATH = File.join(File.dirname(__FILE__), "sample_data")

  context "(in general)" do
    let(:blank_worksheet) { GSP::Documents::MsOffice::Excel::Spreadsheet::Worksheet.new }

    it "should contain file_name, file_path, data, and csv" do
      expect(blank_worksheet).to respond_to :file_name
      expect(blank_worksheet).to respond_to :file_path
      expect(blank_worksheet).to respond_to :data
      expect(blank_worksheet).to respond_to :csv
    end
  end

  context "during loading from CSV" do
    let(:csv_based_worksheet) { GSP::Documents::MsOffice::Excel::Spreadsheet::Worksheet.load_csv(File.join(SAMPLE_DATA_PATH, "sample.csv")) }

    it "should generate a Worksheet from a CSV file" do
      expect(csv_based_worksheet).to be_kind_of GSP::Documents::MsOffice::Excel::Spreadsheet::Worksheet
      expect(csv_based_worksheet.file_name).to eq "sample.csv"
      expect(csv_based_worksheet.file_path).to eq File.join(SAMPLE_DATA_PATH, "sample.csv")
      expect(csv_based_worksheet.data).not_to be_empty
      expect(csv_based_worksheet.csv).to be_kind_of CSV
    end
  end
end
