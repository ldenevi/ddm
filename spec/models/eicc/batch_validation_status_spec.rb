require 'spec_helper'

describe Eicc::BatchValidationStatus do
  context "(in general)" do
    let(:status) { Eicc::BatchValidationStatus.new }
    it "should be valid" do
      status.should_not be_valid
    end

    it "should export validation and source data in Zip format" do
      status.should respond_to :export_data
      status.should
    end
  end
end
