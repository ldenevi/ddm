require 'spec_helper'

describe Cfsi::CmrtValidation do
  let(:empty_validation) { Cfsi::CmrtValidation.create }
  let(:empty_cmrt_file_path) { File.join(File.dirname(__FILE__), 'sample_cmrts', '3.01', '3.01_-_empty.xls') }

  context "(in general)" do
    it "should have required attributes" do
      [:cmrt, :email_sent_at, :issues, :sent_emails_count, :status, :validation_attempt,
       :validations_batch, :vendor].each do |attr|
       expect(empty_validation).to respond_to attr
      end
    end

    pending "email CMRT issues to vendor"
    pending "discover the CMRT's MineralsVendor"
  end

  context "during state changes" do
    it "should transition from 'Initialized' to 'Validation needed'" do
      expect(empty_validation).to respond_to :transition_to
      expect(empty_validation.state).to eq "Initialized"
      expect(empty_validation.transition_to_opened(empty_cmrt_file_path)).to be_true
      empty_validation.reload
      expect(empty_validation.state).to eq "Opened"
      expect(empty_validation.transition_to_validated).to be_true
      empty_validation.reload
      expect(empty_validation.state).to eq "Validation needed"
    end

    let(:high_risk_validation) { Cfsi::CmrtValidation.create }
    let(:high_risk_cmrt_file_path) { File.join(File.dirname(__FILE__), 'sample_cmrts', '3.01', '3.01_-_filled.xls') }
    it "should transition from 'Initialized' to 'High risk'" do
      expect(high_risk_validation).to respond_to :transition_to
      expect(high_risk_validation.state).to eq "Initialized"
      expect(high_risk_validation.transition_to_opened(high_risk_cmrt_file_path)).to be_true
      high_risk_validation.reload
      expect(high_risk_validation.state).to eq "Opened"
      expect(high_risk_validation.transition_to_validated).to be_true
      high_risk_validation.reload
      expect(high_risk_validation.state).to eq "High risk"
    end

    let(:green_validation) { Cfsi::CmrtValidation.create }
    let(:cmrt_file_path) { File.join(File.dirname(__FILE__), 'sample_cmrts', '2.03a', '2.03a_-_valid_1.xls') }
    it "should transition from 'Initialized' to 'Green'" do
      expect(green_validation).to respond_to :transition_to
      expect(green_validation.state).to eq "Initialized"
      expect(green_validation.transition_to_opened(cmrt_file_path)).to be_true
      green_validation.reload
      expect(green_validation.state).to eq "Opened"
      expect(green_validation.transition_to_validated).to be_true
      green_validation.reload
      expect(green_validation.state).to eq "Green"
    end
  end
end
