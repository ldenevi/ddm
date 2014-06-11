require 'spec_helper'

describe GSP::Documents::Conversion::OfficeConvert do
  XLSX_SPREADSHEET_FILE_PATH = File.join('spec', 'lib', 'documents', 'conversion', 'sample_data', 'sample_2_worksheets.xlsx')
  OUTPUT_DIR_PATH = File.join('tmp', 'gsp', 'documents', 'conversions')
  let(:xlsx_to_xls) { GSP::Documents::Conversion::OfficeConvert.to_xls(XLSX_SPREADSHEET_FILE_PATH, :output_dir_path => OUTPUT_DIR_PATH) }
  it "should convert .xlsx to .xls" do
    expect(xlsx_to_xls).to eq File.join(OUTPUT_DIR_PATH, 'sample_2_worksheets.xlsx.xls')
    expect(File.exists?(File.join(OUTPUT_DIR_PATH, 'sample_2_worksheets.xlsx.xls'))).to be_true
    require 'fileutils'
    FileUtils.rm_r(OUTPUT_DIR_PATH)
    expect(File.exists?(File.join(OUTPUT_DIR_PATH, 'sample_2_worksheets.xlsx.xls'))).to be_false
  end
end
