require 'spec_helper'

describe Cfsi::ConfirmedSmelter do
  let(:cs) { FactoryGirl.build(:cfsi_confirmed_smelter)  }
  let(:blank_cs) { Cfsi::ConfirmedSmelter.new }

  context "(in general)" do
   it "should have required attributes" do
    [:invalid_at, :locations, :mineral, :name, :source, :status, :v3_smelter_id].each do |attr|
      expect(cs).to respond_to attr
    end
   end

   it "should validate presence of required fields" do
    expect(blank_cs).not_to be_valid
    expect(cs).to be_valid
   end
 end
end
