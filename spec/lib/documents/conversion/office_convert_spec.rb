require 'spec_helper'

describe GSP::Documents::Conversion::OfficeConvert do
  let(:xlsx_spreadsheet_file_path) { File.join('spec', 'lib', 'documents', 'conversion', 'sample_data', 'sample_2_worksheets.xlsx') }
  let(:output_dir_path) { File.join('tmp', 'gsp', 'documents', 'conversions') }

  let(:xlsx_to_worksheets) { GSP::Documents::Conversion::OfficeConvert.convert(xlsx_spreadsheet_file_path, :output_dir_path => output_dir_path) }
  it "should convert .xlsx to .xls (97-2003)" do
    expect(xlsx_to_worksheets).to eq File.join(output_dir_path, 'worksheets.zip')
    expect(File.exists?(File.join(output_dir_path, 'worksheets.zip'))).to be_true
    require 'fileutils'
    FileUtils.rm_r(output_dir_path)
    expect(File.exists?(File.join(output_dir_path, 'worksheets.zip'))).to be_false
  end
end
