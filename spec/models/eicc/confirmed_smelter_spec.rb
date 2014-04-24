require 'spec_helper'

describe Eicc::ConfirmedSmelter do
  context "(in general)" do
    let(:confirmed_smelter) { Eicc::ConfirmedSmelter.new }

    it "should respond to expected attributes" do
      [:metal, :standard_smelter_id, :smelter_name, :locations, :invalid_at, :conflict_mineral_policy_url, :user].each do |attr|
        confirmed_smelter.should respond_to(attr)
      end
    end

    it "should import data from file" do
      FactoryGirl.create_list(:confirmed_smelter, 15)
      Eicc::ConfirmedSmelter.count.should eq 15
      Eicc::ConfirmedSmelter.should respond_to(:from_file)
      Eicc::ConfirmedSmelter.from_file("./spec/models/eicc/confirmed_smelters_list.csv")
      Eicc::ConfirmedSmelter.count.should eq 20
    end
  end
end
