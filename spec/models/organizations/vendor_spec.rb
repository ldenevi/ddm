require 'spec_helper'

describe Vendor do
  let(:vendor) { FactoryGirl.create :vendor }

  context "(in general)" do
    it "should have required attributes" do
      expect(vendor).to respond_to :division
    end
  end
end
