require 'spec_helper'

describe Cfsi::StandardSmelterName do
  context "(in general)" do
    let(:standard_smelter_name) { FactoryGirl.build(:cfsi_standard_smelter_name) }

    it "should contain required data" do
      [:facility_location_country, :known_alias, :metal, :smelter_id,
       :standard_smelter_name].each do |attr|
        expect(standard_smelter_name).to respond_to attr
      end
      expect(standard_smelter_name).to respond_to :declaration
      expect(standard_smelter_name).to respond_to :organization
    end
  end
end
