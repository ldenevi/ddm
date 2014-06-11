require 'spec_helper'

describe GSP::Documents::MsOffice::Excel::Spreadsheet do
  context "(in general)" do
    let(:spreadsheet) { GSP::Documents::MsOffice::Excel::Spreadsheet.new File.join(%w(spec lib conversion sample_data sample_2_worksheets.xls)) }

    it "should contain file_name, file_path" do
      expect(spreadsheet).to respond_to :file_name
      expect(spreadsheet).to respond_to :file_path
    end
  end
end
