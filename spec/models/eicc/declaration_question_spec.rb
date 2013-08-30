require 'spec_helper'

describe Eicc::DeclarationQuestion do
  context "during invalid Declaration processing" do
    let(:invalid_doc) { Eicc::DeclarationQuestion.new }
    
    it "should be invalid" do
      invalid_doc.should_not be_valid
    end
  end
  
  context "during valid Declaration processing" do
    let(:valid_doc) { Eicc::DeclarationQuestion.new :sequence => 1, :question => "1) Are any of the following metals necessary to the functionality or production of your company's products that it manufactures or contracts to manufacture? (*)", :tantalum => "Yes", :tantalum_comment => "Tantalum in the head", :tungsten => "Yes", :tungsten_comment => "In the joints", :tin => "No", :tin_comment => "Been using aluminum", :gold => "Yes", :gold_comment => "In the teeth" }
  
    it "should populate this with mineral replies" do
      valid_doc.should be_valid
    end
  end
end
