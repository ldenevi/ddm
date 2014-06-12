require 'spec_helper'
require 'fileutils'

describe GSP::Documents::Conversion::OfficeConvert::Excel do
  let(:xlsx_file_path) { File.join(File.dirname(__FILE__), '..', 'sample_data', 'sample_2_worksheets.xlsx') }
  let(:output_dir_path) { File.join('tmp', 'test', 'gsp_documents_conversion_officeconvert_excel') }

  let(:xlsx_to_xls97) { GSP::Documents::Conversion::OfficeConvert::Excel.to_xls_97 xlsx_file_path, :output_dir_path => File.join(output_dir_path, 'xlsx_to_xls97') }
  it "should convert spreadsheet to Excel 97-2003 (.xls)" do
    expect(GSP::Documents::Conversion::OfficeConvert::Excel).to respond_to :to_xls_97
    expect(xlsx_to_xls97).to match /xlsx_to_xls97\/sample_2_worksheets.xlsx.xls$/
    expect(File.exists?(xlsx_to_xls97)).to be_true
    FileUtils.rm_r(xlsx_to_xls97)
    expect(File.exists?(xlsx_to_xls97)).to be_false
  end

  let(:xlsx_to_xls4) { GSP::Documents::Conversion::OfficeConvert::Excel.to_xls_4 xlsx_file_path, :output_dir_path => File.join(output_dir_path, 'xlsx_to_xls4') }
  it "should convert spreadsheet to Excel 4.0 (.xls)" do
    expect(GSP::Documents::Conversion::OfficeConvert::Excel).to respond_to :to_xls_4
    expect(xlsx_to_xls4).to match /xlsx_to_xls4\/sample_2_worksheets.xlsx.xls$/
    expect(File.exists?(xlsx_to_xls4)).to be_true
    FileUtils.rm_r(xlsx_to_xls4)
    expect(File.exists?(xlsx_to_xls4)).to be_false
  end

  let(:xlsx_to_xls5) { GSP::Documents::Conversion::OfficeConvert::Excel.to_xls_5 xlsx_file_path, :output_dir_path => File.join(output_dir_path, 'xlsx_to_xls5') }
  it "should convert spreadsheet to Excel 5.0 (.xls)" do
    expect(GSP::Documents::Conversion::OfficeConvert::Excel).to respond_to :to_xls_5
    expect(xlsx_to_xls5).to match /xlsx_to_xls5\/sample_2_worksheets.xlsx.xls$/
    expect(File.exists?(xlsx_to_xls5)).to be_true
    FileUtils.rm_r(xlsx_to_xls5)
    expect(File.exists?(xlsx_to_xls5)).to be_false
  end

  let(:xlsx_to_csv) { GSP::Documents::Conversion::OfficeConvert::Excel.to_csv xlsx_file_path, :output_dir_path => File.join(output_dir_path, 'xlsx_to_csv') }
  it "should convert spreadsheet to CSV (.csv)" do
    expect(GSP::Documents::Conversion::OfficeConvert::Excel).to respond_to :to_csv
    expect(xlsx_to_csv).not_to be_empty
    expect(xlsx_to_csv[0]).to match /xlsx_to_csv\/sample_2_worksheets.xlsx.csv.0$/
    expect(xlsx_to_csv[1]).to match /xlsx_to_csv\/sample_2_worksheets.xlsx.csv.1$/
    expect(File.exists?(xlsx_to_csv[0])).to be_true
    expect(File.exists?(xlsx_to_csv[1])).to be_true
    FileUtils.rm_r(xlsx_to_csv)
    expect(File.exists?(xlsx_to_csv)).to be_false
  end

  it "should convert spreadsheet to Open Document spreadsheet (.ods)" do
    expect(GSP::Documents::Conversion::OfficeConvert::Excel).to respond_to :to_open_document_spreadsheet
  end
end
