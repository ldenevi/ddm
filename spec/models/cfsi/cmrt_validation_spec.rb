require 'spec_helper'

describe Cfsi::CmrtValidation do
  let(:user) { FactoryGirl.create(:user) }
  let(:org)  { FactoryGirl.create(:organization) }

  let(:batch) { Cfsi::ValidationsBatch.new :user => user, :organization => org }
  let(:empty_validation) { Cfsi::CmrtValidation.create :user => user, :organization => org, :validations_batch => batch }
  let(:empty_cmrt_file_path) { File.join(File.dirname(__FILE__), 'sample_cmrts', '3.01', '3.01_-_empty.xlsx') }

  context "(in general)" do
    it "should save" do
      expect(empty_validation.save).to be_true
    end

    it "should have required attributes" do
      [:cmrt, :email_sent_at, :issues, :sent_emails_count, :status, :validation_attempt,
       :validations_batch, :vendor, :spreadsheet, :file_name, :file_extension, :file_path].each do |attr|
       expect(empty_validation).to respond_to attr
      end

      expect(empty_validation).to respond_to :has_cmrt?
      expect(empty_validation).to respond_to :has_declaration?

      expect(empty_validation).to respond_to :organization
      expect(empty_validation).to respond_to :user
    end

    pending "email CMRT issues to vendor"
    pending "discover the CMRT's MineralsVendor"
  end

  context "during state changes" do
    let(:validation_needed_cmrt_file_path) { File.join(File.dirname(__FILE__), 'sample_cmrts', '3.01', '3.01_-_validation_needed.xlsx') }
    it "should transition from 'Initialized' to 'Validation needed'" do
      validation_needed_validation = Cfsi::CmrtValidation.generate validation_needed_cmrt_file_path, :user => user, :organization => org, :validations_batch => batch
      expect(validation_needed_validation).to respond_to :transition_to
      expect(validation_needed_validation.state).to eq "Initialized"
      expect(validation_needed_validation.transition_to_opened).to be_true
      validation_needed_validation.reload
      expect(validation_needed_validation.state).to eq "Opened"
      expect(validation_needed_validation.transition_to_validated).to be_true
      validation_needed_validation.reload
      expect(validation_needed_validation.state).to eq "Validation needed"
    end

    let(:high_risk_cmrt_file_path) { File.join(File.dirname(__FILE__), 'sample_cmrts', '3.01', '3.01_-_high_risk.xlsx') }
    it "should transition from 'Initialized' to 'High risk'" do
      high_risk_validation = Cfsi::CmrtValidation.generate high_risk_cmrt_file_path, :user => user, :organization => org, :validations_batch => batch
      expect(high_risk_validation).to respond_to :transition_to
      expect(high_risk_validation.state).to eq "Initialized"
      expect(high_risk_validation.transition_to_opened).to be_true
      high_risk_validation.reload
      expect(high_risk_validation.state).to eq "Opened"
      expect(high_risk_validation.transition_to_validated).to be_true
      high_risk_validation.reload
      expect(high_risk_validation.state).to eq "High risk"
    end

    let(:green_file_path) { File.join(File.dirname(__FILE__), 'sample_cmrts', '3.01', '3.01_-_green.xlsx') }
    it "should transition from 'Initialized' to 'Green'" do
      green_validation = Cfsi::CmrtValidation.generate green_file_path, :user => user, :organization => org, :validations_batch => batch
      expect(green_validation).to respond_to :transition_to
      expect(green_validation.state).to eq "Initialized"
      expect(green_validation.transition_to_opened).to be_true
      green_validation.reload
      expect(green_validation.state).to eq "Opened"
      expect(green_validation.transition_to_validated).to be_true
      green_validation.reload
      expect(green_validation.state).to eq "Green"
    end

    let(:file_not_readable_file_path) { File.join(File.dirname(__FILE__), 'sample_cmrts', 'invalid_cmrt.xls') }
    let(:file_not_readable_validation) { Cfsi::CmrtValidation.generate file_not_readable_file_path, :user => user, :organization => org, :validations_batch => batch }
    it "should transition from 'Initialized' to 'File not readable'" do
      expect(file_not_readable_validation).to respond_to :transition_to
      expect(file_not_readable_validation.state).to eq "Initialized"
      expect(file_not_readable_validation.transition_to_opened).to be_true
      file_not_readable_validation.reload
      expect(file_not_readable_validation.state).to eq "File not readable"
    end

  end
end
