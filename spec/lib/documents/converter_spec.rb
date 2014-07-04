require 'spec_helper'

describe GSP::Documents::Converter do
  let(:xls_spreadsheet_file_path) { File.join('spec', 'lib', 'documents', 'conversion', 'sample_data', 'sample_2_worksheets.xls') }

  let(:xls_to_csv) { GSP::Documents::Converter.xls_to_csv xls_spreadsheet_file_path }
  it "should convert .xls to .csv" do
    expect(GSP::Documents::Converter).to respond_to :xls_to_csv
    expect(xls_to_csv).not_to be_empty
    expect(xls_to_csv.first).to be_kind_of GSP::Documents::MsOffice::Excel::Spreadsheet::Worksheet
    expect(xls_to_csv[0].file_name).to eq "sample_2_worksheets.csv.0"
    expect(xls_to_csv[1].file_name).to eq "sample_2_worksheets.csv.1"
  end
end
