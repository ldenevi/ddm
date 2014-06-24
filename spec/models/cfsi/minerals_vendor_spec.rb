require 'spec_helper'

describe Cfsi::MineralsVendor do
  let(:blank_minerals_vendor) { Cfsi::MineralsVendor.new }

  context "(in general)" do
    it "should contain blank_cmrt data that uniquely identifies the minerals vendor" do
      expect(blank_minerals_vendor).to respond_to :cfsi_confirmed_at
      expect(blank_minerals_vendor).to respond_to :minerals
      expect(blank_minerals_vendor).to respond_to :query_match_data

      # expect(blank_minerals_vendor).to respond_to :organization
    end
  end
end
