require 'spec_helper'

describe Eicc::MineralsQuestion do
  context "(in general)" do
    let(:minerals_question) { Eicc::MineralsQuestion.new }

    it "should respond to 3TGs and associated comments" do
      minerals_question.should respond_to :gold
      minerals_question.should respond_to :gold_comment
      minerals_question.should respond_to :tin
      minerals_question.should respond_to :tin_comment
      minerals_question.should respond_to :tungsten
      minerals_question.should respond_to :tungsten_comment
      minerals_question.should respond_to :tantalum
      minerals_question.should respond_to :tantalum_comment
    end
  end
end
