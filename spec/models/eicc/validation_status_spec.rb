require 'spec_helper'

describe Eicc::ValidationStatus do
  
  context "(in general)" do
    let(:status) { Eicc::ValidationStatus.new }
    it "should be valid" do
      status.should_not be_valid
    end
    
    it "should respond to uploaded_at" do
      expect(status).to respond_to(:uploaded_at)
      expect(status).to respond_to(:individual_validation_statuses)
      expect(status).to respond_to(:completed)
      expect(status).to respond_to(:validating)
    end
  end
      
end
