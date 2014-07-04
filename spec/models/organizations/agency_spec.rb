require 'spec_helper'

describe Agency do
  let(:agency) { FactoryGirl.create :agency }
  context "(in general)" do
    it "should have required attributes" do
      expect(agency).to respond_to :url
    end
  end
end
