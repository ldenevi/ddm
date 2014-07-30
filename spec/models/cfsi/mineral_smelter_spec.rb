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
      expect(mineral_smelter).to respond_to :organization
      # Helper methods
      expect(mineral_smelter).to respond_to :smelter_id
      expect(mineral_smelter).to respond_to :vendor_key
      expect(mineral_smelter.vendor_key).to eq ["gold", "western australian mint trading as the perth mint", "australia"]

      expect(mineral_smelter).to respond_to :has_valid_smelter_id?
      expect(mineral_smelter).to respond_to :has_valid_non_smelter_id?
      expect(mineral_smelter).to respond_to :does_mineral_match_v2_smelter_id?
      expect(mineral_smelter).to respond_to :has_valid_smelter_name?
      expect(mineral_smelter).to respond_to :has_valid_mineral?
    end
  end

  it "should test for valid smelter id" do
    ms = Cfsi::MineralSmelter.new
    ms.smelter_id = "1AUS046"
    expect(ms.has_valid_smelter_id?).to be_true
    ms.smelter_id = "CID012345"
    expect(ms.has_valid_smelter_id?).to be_true
    ms.smelter_id = "gibberish"
    expect(ms.has_valid_smelter_id?).to be_false
  end

  it "should test for valid non smelter id" do
    ms = Cfsi::MineralSmelter.new
    ms.smelter_id = "1AUS046"
    expect(ms.has_valid_non_smelter_id?).to be_false
    ms.smelter_id = "CID012345"
    expect(ms.has_valid_non_smelter_id?).to be_false
    ms.smelter_id = "gibberish"
    expect(ms.has_valid_non_smelter_id?).to be_false
    ms.smelter_id = "Not Listed"
    expect(ms.has_valid_non_smelter_id?).to be_true
    ms.smelter_id = "Not Supplied"
    expect(ms.has_valid_non_smelter_id?).to be_true
    ms.smelter_id = "Unknown"
    expect(ms.has_valid_non_smelter_id?).to be_true
  end

  it "should test for valid smelter name" do
    ms = Cfsi::MineralSmelter.new
    ms.standard_smelter_name = "Western Australian Mint trading as The Perth Mint"
    expect(ms.has_valid_smelter_name?).to be_true
    ms.standard_smelter_name = "???????????????????????"
    expect(ms.has_valid_smelter_name?).to be_false
    ms.standard_smelter_name = ""
    expect(ms.has_valid_smelter_name?).to be_false
    ms.standard_smelter_name = nil
    expect(ms.has_valid_smelter_name?).to be_false
  end

  it "should test that v2 smelter id matches metal" do
    ms = Cfsi::MineralSmelter.new :v2_smelter_id => '1AUS046', :metal => 'Gold'
    expect(ms.does_mineral_match_v2_smelter_id?).to be_true
    ms.v2_smelter_id = '2AUS046'
    expect(ms.does_mineral_match_v2_smelter_id?).to be_false
  end

  it "should test for valid mineral" do
    ms = Cfsi::MineralSmelter.new
    ms.metal = "Gold"
    expect(ms.has_valid_mineral?).to be_true
    ms.metal = "Tin"
    expect(ms.has_valid_mineral?).to be_true
    ms.metal = "Tungsten"
    expect(ms.has_valid_mineral?).to be_true
    ms.metal = "Tantalum"
    expect(ms.has_valid_mineral?).to be_true
    ms.metal = ""
    expect(ms.has_valid_mineral?).to be_true
    ms.metal = nil
    expect(ms.has_valid_mineral?).to be_true
    ms.metal = "Arsenic"
    expect(ms.has_valid_mineral?).to be_false
  end

  it "should search for and fill v3 ID based on v2 ID" do
    ms = Cfsi::MineralSmelter.new :standard_smelter_name => 'Allgemeine Gold-und Silberscheideanstalt A.G.', :metal => 'Gold',
                                     :facility_location_country => 'Germany', :v2_smelter_id => '1DEU001'

    expect(ms).to respond_to :set_v3_smelter_id_from_v2_smelter_id
    expect(ms.v3_smelter_id).to eq 'CID000035'
  end




end
