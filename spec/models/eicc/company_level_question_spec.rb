require 'spec_helper'

describe Eicc::CompanyLevelQuestion do
  context "(in general)" do
    let(:question) { Eicc::CompanyLevelQuestion.new }
    it "should validate for question and answer fields" do
      question.should_not be_valid
    end
  end
  
  context "during invalid company level queation processing" do
    let(:clq) { Eicc::CompanyLevelQuestion.new :sequence => "Teerrrible", :question => "", :answer => "perhaps", :comment => "" }
    it "should populate this with mineral replies" do
      clq.should_not be_valid
      expect(clq.errors.full_messages).to include("Question can't be blank")
      expect(clq.errors.full_messages).to include("Sequence 'Teerrrible' is not a number")
      expect(clq.errors.full_messages).to include("Answer 'perhaps' is not either 'Yes' or 'No'")
    end
  end
end
