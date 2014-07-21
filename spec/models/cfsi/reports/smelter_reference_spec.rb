require 'spec_helper'

describe Cfsi::Reports::SmelterReference do
  let(:sr) { FactoryGirl.create(:cfsi_reports_smelter_reference) }

  context "(in general)" do
    it "should have required attributes and methods" do
      [:metal, :country, :standard_name, :key_terms, :v2_smelter_id, :v3_smelter_id].each do |attr|
        expect(sr).to respond_to attr
      end
      expect(sr.key_terms).to be_kind_of Array
      expect(Cfsi::Reports::SmelterReference).to respond_to :get_gsp_standard_name_matches
      expect(Cfsi::Reports::SmelterReference).to respond_to :get_standard_names_for
      expect(Cfsi::Reports::SmelterReference).to respond_to :import_from_csv
      expect(Cfsi::Reports::SmelterReference).to respond_to :import_from_csv_file_path
    end

    let(:om_smelter) do Cfsi::MineralSmelter.new :standard_smelter_name => 'O.M. Manufacturing Philippines, Inc.',
                                            :metal => 'Tin',
                                            :facility_location_city => 'Peza - Rosario',
                                            :facility_location_country => 'Philippines',
                                            :facility_location_province => 'Cavite'
    end
    before(:all) do
      Cfsi::Reports::SmelterReference.create :country => 'Thailand',
                                              :key_terms => ['O.M.', 'Thailand'],
                                              :metal => 'Tin',
                                              :standard_name => 'O.M. Manufacturing (Thailand) Co., Ltd.',
                                              :v3_smelter_id => 'CID001314'
      Cfsi::Reports::SmelterReference.create :country => 'Philippines',
                                              :key_terms => ['O.M.', 'Philippines'],
                                              :metal => 'Tin',
                                              :standard_name => 'O.M. Manufacturing (Philippines) Co., Ltd.',
                                              :v3_smelter_id => 'CID001314'
    end

    it "should output a non-weighted match on a smelter" do
      expect(Cfsi::Reports::SmelterReference.get_standard_names_for(om_smelter, :use_key_terms => false)).to eq ["O.M. Manufacturing (Thailand) Co., Ltd."]
    end

    it "should output a weighted match on a smelter" do
      expect(Cfsi::Reports::SmelterReference.get_standard_names_for(om_smelter, :use_key_terms => true)).to eq ["O.M. Manufacturing (Philippines) Co., Ltd."]
    end
  end

  context "during CSV import" do
    before(:all) do
      Cfsi::Reports::SmelterReference.destroy_all
    end
    it "should import data" do
      expect { Cfsi::Reports::SmelterReference.import_from_csv_file_path(File.join(File.dirname(__FILE__), 'sample_data', 'smelter_references.csv')) }.to change { Cfsi::Reports::SmelterReference.count }.by 223
    end
  end
end
