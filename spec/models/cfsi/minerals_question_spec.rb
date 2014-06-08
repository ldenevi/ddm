require 'spec_helper'

describe Cfsi::MineralsQuestion do
  context "(in general)" do
    let(:blank_minerals_question) { FactoryGirl.build(:cfsi_minerals_question) }

    it "should contain required data" do
      [:sequence, :question, :gold, :gold_comment, :tantalum, :tantalum_comment,
       :tin, :tin_comment, :tungsten, :tungsten_comment].each do |attr|
       expect(blank_minerals_question).to respond_to attr
      end
    end

    it "should associate to a Cfsi::Declaration" do
      expect(blank_minerals_question).to respond_to :declaration
      expect(blank_minerals_question.declaration).to be_kind_of Cfsi::Declaration
    end

  end
end
