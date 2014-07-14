require 'spec_helper'

describe Cfsi::MineralSmelter do
  let(:mineral_smelter) { FactoryGirl.build(:cfsi_mineral_smelter) }

  context "(in general)" do
    it "should contain all required data" do
      [:comment, :facility_contact_email, :facility_contact_name,
        :facility_location_city, :facility_location_country,
        :facility_location_province, :facility_location_street_address,
        :line_number, :metal, :mineral_source, :mineral_source_location,
        :proposed_next_steps, :smelter_reference_list,
        :standard_smelter_name, :source_of_smelter_id,
        :is_all_smelter_feedstock_from_recycled_sources,
        :v2_smelter_id, :v3_smelter_id].each do |attr|
        expect(mineral_smelter).to respond_to attr
      end
      expect(mineral_smelter).to respond_to :declaration
      # Helper methods
      expect(mineral_smelter).to respond_to :smelter_id
      expect(mineral_smelter).to respond_to :organization
      expect(mineral_smelter).to respond_to :vendor_key
      expect(mineral_smelter.vendor_key).to eq "MyString"
    end
  end
end
