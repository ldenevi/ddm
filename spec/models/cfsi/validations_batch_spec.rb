require 'spec_helper'

describe Cfsi::ValidationsBatch do
  let(:batch) { FactoryGirl.create(:cfsi_validations_batch) }
  context "(in general)" do
    it "should have required attributes" do
      [:unidentified_cmrts, :vendor_cmrts, :status, :user, :organization].each do |attr|
        expect(batch).to respond_to attr
      end
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
  end
end
