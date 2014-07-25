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
  end

  context "during CSV import" do
    before(:all) do
      Cfsi::Reports::SmelterReference.destroy_all
    end
    it "should import data" do
      expect { Cfsi::Reports::SmelterReference.import_from_csv_file_path(File.join(File.dirname(__FILE__), 'sample_data', 'smelter_references.csv')) }.to change { Cfsi::Reports::SmelterReference.count }.by 223
    end
  end

  context "on standard name matching" do
  end
end
