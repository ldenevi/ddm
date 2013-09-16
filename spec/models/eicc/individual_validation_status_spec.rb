require 'spec_helper'

describe Eicc::IndividualValidationStatus do
  context "(in general)" do
    let(:status) { Eicc::IndividualValidationStatus.new }
    it "should be valid" do
      status.should_not be_valid
    end
  end
end
