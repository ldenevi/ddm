require 'spec_helper'

describe Eicc::SmelterList do
  context "(in general)" do
    let(:smelter) { Eicc::SmelterList.new }
    it "should respond to metal, reference, smelter name, smelter location fields" do
      smelter.should be_valid
      smelter.should respond_to :metal
      smelter.should respond_to :smelter_reference_list
      smelter.should respond_to :standard_smelter_name
      smelter.should respond_to :facility_location_country
    end
  end

end
