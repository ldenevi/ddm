require 'spec_helper'

describe GSP::Documents::Conversion::SSConvert do
  let(:xls_spreadsheet_file_path) { File.join('spec', 'lib', 'documents', 'conversion', 'sample_data', 'sample_2_worksheets.xls') }

  let(:ssconvert) { GSP::Documents::Conversion::SSConvert.new(xls_spreadsheet_file_path) }
  it "should have required attributes" do
    [:raw_output, :outputs, :exporter, :errors, :spreadsheet_file_path, :spreadsheet_file_name, :output_directory_path, :worksheets].each do |attr|
      expect(ssconvert).to respond_to attr
    end
  end

  it "should probe system for 'ssconvert'" do
    expect(GSP::Documents::Conversion::SSConvert).to respond_to :is_ssconvert_installed?
    expect(GSP::Documents::Conversion::SSConvert.is_ssconvert_installed?).to be_true
  end

  it "should raise FileNotFound exception" do
    expect { GSP::Documents::Conversion::SSConvert.to_csv("this/file/should/not/exist.nope") }.to raise_error GSP::Documents::Conversion::SSConvert::Exceptions::FileNotFound
  end

  let(:xls_to_csv_ssconvert) { GSP::Documents::Conversion::SSConvert.to_csv(xls_spreadsheet_file_path) }
  it "should convert .xls to .csv" do
    expect(GSP::Documents::Conversion::SSConvert).to respond_to :to_csv
    expect(xls_to_csv_ssconvert).not_to be_nil
    expect(xls_to_csv_ssconvert.worksheets).not_to be_empty
    expect(xls_to_csv_ssconvert.worksheets[0].file_name).to eq "sample_2_worksheets.csv.0"
    expect(xls_to_csv_ssconvert.worksheets[1].file_name).to eq "sample_2_worksheets.csv.1"
    expect(File.exists?(xls_to_csv_ssconvert.output_directory_path)).to be_false
  end

  let(:keep_output_files) { GSP::Documents::Conversion::SSConvert.to_csv(xls_spreadsheet_file_path, :delete_output_files => false) }
  it "should allow to keep temporary output files" do
    expect(File.exists?(keep_output_files.output_directory_path)).to be_true
    require 'fileutils'
    FileUtils.rm_r(keep_output_files.output_directory_path)
    expect(File.exists?(keep_output_files.output_directory_path)).to be_false
  end
end
