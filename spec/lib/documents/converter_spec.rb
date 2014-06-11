require 'spec_helper'

describe GSP::Documents::Converter do
  XLS_SPREADSHEET_FILE_PATH  = File.join('spec', 'lib', 'documents', 'conversion', 'sample_data', 'sample_2_worksheets.xls')
  XLSX_SPREADSHEET_FILE_PATH = File.join('spec', 'lib', 'documents', 'conversion', 'sample_data', 'sample_2_worksheets.xlsx')

  let(:xls_to_csv) { GSP::Documents::Converter.xls_to_csv XLS_SPREADSHEET_FILE_PATH }
  it "should convert .xls to .csv" do
    expect(GSP::Documents::Converter).to respond_to :xls_to_csv
    expect(xls_to_csv).not_to be_empty
    expect(xls_to_csv.first).to be_kind_of GSP::Documents::MsOffice::Excel::Spreadsheet::Worksheet
    expect(xls_to_csv[0].file_name).to eq "sample_2_worksheets.csv.0"
    expect(xls_to_csv[1].file_name).to eq "sample_2_worksheets.csv.1"
  end

  let(:xlsx_to_xls) { GSP::Documents::Converter.xlsx_to_xls(XLSX_SPREADSHEET_FILE_PATH, File.join('tmp', 'gsp', 'documents', 'test')) }
  it "should convert .xlsx to .xls" do
    expect(GSP::Documents::Converter).to respond_to :xlsx_to_xls
    expect(xlsx_to_xls).to be_kind_of GSP::Documents::MsOffice::Excel::Spreadsheet
    expect(xlsx_to_xls.file_name).to eq "sample_2_worksheets.xlsx.xls"
  end
end
