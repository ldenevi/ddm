require 'spec_helper'

describe Cfsi::ValidationsBatch do
  let(:batch) { FactoryGirl.create(:cfsi_validations_batch) }
  context "(in general)" do
    it "should have required attributes" do
      [:unidentified_cmrt_validations, :vendor_cmrt_validations, :status, :user, :organization, :cmrt_validations, :latest_cmrt_validations].each do |attr|
        expect(batch).to respond_to attr
      end
      # Analytics
      [:green_status_validations, :validation_needed_validations, :high_risk_validations, :error_validations].each do |assc|
        expect(batch).to respond_to assc
      end
      expect(batch).to respond_to :organization
      expect(batch).to respond_to :user
    end

    it "should initialize with state as 'Initialized'" do
      expect(batch.state).to eq 'Initialized'
    end

    it "should transition to 'Processing'" do
      expect(batch.transition_to_processing).to be_true
      batch.reload
      expect(batch.state).to eq 'Processing'
    end

    it "should transition to 'Completed'" do
      expect(batch.transition_to_completed).to be_true
      batch.reload
      expect(batch.state).to eq 'Completed'
    end

    it "should list the latest CMRTs from vendors" do
      batch.cmrt_validations = []
      user = User.first
      val1 = Cfsi::CmrtValidation.generate File.join(File.dirname(__FILE__), 'sample_cmrts', '2.03a', '2.03a_-_high_risk.xlsx'), :user => user, :organization => user.organization
      val2 = Cfsi::CmrtValidation.generate File.join(File.dirname(__FILE__), 'sample_cmrts', '3.01', '3.01_-_green.xlsx'), :user => user, :organization => user.organization
      batch.cmrt_validations << val1
      batch.cmrt_validations << val2
      val1.transition_to_opened
      expect(val1.transition_to_validated).to be_true
      val2.transition_to_opened
      expect(val2.transition_to_validated).to be_true
      expect(batch.cmrt_validations.size).to eq 2
      expect(batch.latest_cmrt_validations.size).to eq 1
      expect(batch.latest_cmrt_validations.first.cmrt.version).to eq '3.01'
    end
  end
end
