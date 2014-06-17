require 'spec_helper'

describe Cfsi::Cmrt do
  let(:blank_cmrt) { Cfsi::Cmrt.new }
  let(:vendor_cmrt) { FactoryGirl.build(:vendor_cmrt) }

  context "(in general)" do
    it "should contain blank_cmrt data that uniquely identifies the minerals vendor" do
      expect(blank_cmrt).to respond_to :company_name
      expect(blank_cmrt).to respond_to :file_extension
      expect(blank_cmrt).to respond_to :file_name
      expect(blank_cmrt).to respond_to :language
      expect(blank_cmrt).to respond_to :meta_data
      expect(blank_cmrt).to respond_to :representative_email
      expect(blank_cmrt).to respond_to :version
    end

    it "should contain relevant associations" do
      expect(blank_cmrt).to respond_to :declaration
      expect(blank_cmrt).to respond_to :minerals_vendor
    end

    it "should find MineralsVendor based on unique identifier data" do
      expect(vendor_cmrt).to respond_to :find_minerals_vendor
      Cfsi::MineralsVendor.create :full_name => "Test",  :properties => {:query_match_data => vendor_cmrt.minerals_vendor_unique_identifier}
      expect(vendor_cmrt.find_minerals_vendor).to be_kind_of(Cfsi::MineralsVendor)
    end

    it "should create MineralsVendor based on unique identifier data" do
      expect(vendor_cmrt).to respond_to :generate_minerals_vendor
      expect(vendor_cmrt.find_minerals_vendor).to be_nil
      expect(vendor_cmrt.generate_minerals_vendor).to be_kind_of(Cfsi::MineralsVendor)
      expect(vendor_cmrt.find_minerals_vendor).to be_kind_of(Cfsi::MineralsVendor)
    end

    let(:latest_version_cmrt) { Cfsi::Cmrt.generate(File.join(File.dirname(__FILE__), "sample_cmrts", "3.01", "3.01_-_green.xlsx")) }
    it "should generate a Declaration from a CMRT spreadsheet" do
      expect(latest_version_cmrt).to be_kind_of(Cfsi::Cmrt)
      expect(latest_version_cmrt.declaration).not_to be_nil
      expect(latest_version_cmrt.declaration).to be_kind_of Cfsi::Declaration
    end
  end
end
