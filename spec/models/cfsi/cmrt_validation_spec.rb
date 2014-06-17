require 'spec_helper'

describe Cfsi::CmrtValidation do
  let(:empty_validation) { Cfsi::CmrtValidation.create }
  let(:empty_cmrt_file_path) { File.join(File.dirname(__FILE__), 'sample_cmrts', '3.01', '3.01_-_empty.xlsx') }

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
    let(:validation_needed_validation) { Cfsi::CmrtValidation.create }
    let(:validation_needed_cmrt_file_path) { File.join(File.dirname(__FILE__), 'sample_cmrts', '3.01', '3.01_-_validation_needed.xlsx') }
    it "should transition from 'Initialized' to 'Validation needed'" do
      expect(validation_needed_validation).to respond_to :transition_to
      expect(validation_needed_validation.state).to eq "Initialized"
      expect(validation_needed_validation.transition_to_opened(validation_needed_cmrt_file_path)).to be_true
      validation_needed_validation.reload
      expect(validation_needed_validation.state).to eq "Opened"
      expect(validation_needed_validation.transition_to_validated).to be_true
      validation_needed_validation.reload
      expect(validation_needed_validation.state).to eq "Validation needed"
    end

    let(:high_risk_validation) { Cfsi::CmrtValidation.create }
    let(:high_risk_cmrt_file_path) { File.join(File.dirname(__FILE__), 'sample_cmrts', '3.01', '3.01_-_high_risk.xlsx') }
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
    let(:green_file_path) { File.join(File.dirname(__FILE__), 'sample_cmrts', '3.01', '3.01_-_green.xlsx') }
    it "should transition from 'Initialized' to 'Green'" do
      expect(green_validation).to respond_to :transition_to
      expect(green_validation.state).to eq "Initialized"
      expect(green_validation.transition_to_opened(green_file_path)).to be_true
      green_validation.reload
      expect(green_validation.state).to eq "Opened"
      expect(green_validation.transition_to_validated).to be_true
      green_validation.reload
      expect(green_validation.state).to eq "Green"
    end

    let(:file_not_readable_validation) { Cfsi::CmrtValidation.create }
    let(:file_not_readable_file_path) { File.join(File.dirname(__FILE__), 'sample_cmrts', 'invalid_cmrt.xls') }
    it "should transition from 'Initialized' to 'File not readable'" do
      expect(file_not_readable_validation).to respond_to :transition_to
      expect(file_not_readable_validation.state).to eq "Initialized"
      expect(file_not_readable_validation.transition_to_opened(file_not_readable_file_path)).to be_true
      file_not_readable_validation.reload
      expect(file_not_readable_validation.state).to eq "File not readable"
    end

  end
end
