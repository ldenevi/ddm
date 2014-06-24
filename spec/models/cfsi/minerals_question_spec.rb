require 'spec_helper'

describe Cfsi::MineralsQuestion do
  let(:blank_minerals_question) { FactoryGirl.build(:cfsi_minerals_question) }

  context "(in general)" do

    it "should contain required data" do
      [:sequence, :question, :gold, :gold_comment, :tantalum, :tantalum_comment,
       :tin, :tin_comment, :tungsten, :tungsten_comment].each do |attr|
       expect(blank_minerals_question).to respond_to attr
      end

      expect(blank_minerals_question).to respond_to :organization
    end

    it "should associate to a Cfsi::Declaration" do
      expect(blank_minerals_question).to respond_to :declaration
    end

  end
end
