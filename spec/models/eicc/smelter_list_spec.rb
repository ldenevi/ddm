require 'spec_helper'

describe Eicc::SmelterList do
  context "(in general)" do
    let(:smelter) { Eicc::SmelterList.new }
    it "should validate for metal, reference, smelter name, smelter location fields" do
      smelter.should_not be_valid
      expect(smelter.errors.full_messages).to include("Metal can't be blank")
      expect(smelter.errors.full_messages).to include("Smelter reference list can't be blank")
      expect(smelter.errors.full_messages).to include("Standard smelter name can't be blank")
      expect(smelter.errors.full_messages).to include("Facility location country can't be blank")
    end
  end
  
end
