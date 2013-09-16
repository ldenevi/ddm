require 'spec_helper'

describe Eicc::MineralsQuestion do
  context "during invalid Declaration processing" do
    let(:invalid_doc) { Eicc::MineralsQuestion.new }
    
    it "should be invalid" do
      invalid_doc.should_not be_valid
      expect(invalid_doc.errors.full_messages).to include("Sequence '' is not a number")
      expect(invalid_doc.errors.full_messages).to include("Question can't be blank")
      expect(invalid_doc.errors.full_messages).to include("Gold : You must declare if Gold is in use within the scope of products declared within this survey response on the Declaration tab cell D24.")
      expect(invalid_doc.errors.full_messages).to include("Tantalum : You must declare if Tantalum is in use within the scope of products declared within this survey response on the Declaration tab cell D22.")
      expect(invalid_doc.errors.full_messages).to include("Tin : You must declare if Tin is in use within the scope of products declared within this survey response on the Declaration tab cell D23.")
      expect(invalid_doc.errors.full_messages).to include("Tungsten : You must declare if Tungsten is in use within the scope of products declared within this survey response on the Declaration tab cell D25.")
    end
  end
  
  context "during valid Declaration processing" do
    let(:valid_doc) { Eicc::MineralsQuestion.new :sequence => 1, :question => "1) Are any of the following metals necessary to the functionality or production of your company's products that it manufactures or contracts to manufacture? (*)", :tantalum => "Yes", :tantalum_comment => "Tantalum in the head", :tungsten => "Yes", :tungsten_comment => "In the joints", :tin => "No", :tin_comment => "Been using aluminum", :gold => "Yes", :gold_comment => "In the teeth" }
  
    it "should populate this with mineral replies" do
      valid_doc.should be_valid
    end
  end
end
