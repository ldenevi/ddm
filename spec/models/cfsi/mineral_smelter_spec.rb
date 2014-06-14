require 'spec_helper'

describe Cfsi::MineralSmelter do
  context "(in general)" do
    let(:mineral_smelter) { FactoryGirl.build(:cfsi_mineral_smelter) }
    it "should contain all required data" do
      [:comment, :facility_contact_email, :facility_contact_name,
        :facility_location_city, :facility_location_country,
        :facility_location_province, :facility_location_street_address,
        :line_number, :metal, :mineral_source, :mineral_source_location,
        :proposed_next_steps, :smelter_id, :smelter_reference_list,
        :standard_smelter_name, :source_of_smelter_id,
        :is_all_smelter_feedstock_from_recycled_sources].each do |attr|
        expect(mineral_smelter).to respond_to attr
      end
      expect(mineral_smelter).to respond_to :declaration
      expect(mineral_smelter.declaration).to be_kind_of Cfsi::Declaration
    end
  end
end
