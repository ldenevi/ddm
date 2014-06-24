require 'spec_helper'

describe Cfsi::CompanyLevelQuestion do
  let(:clq)  { FactoryGirl.build(:cfsi_company_level_question) }

  context "(in general)" do
    it "should save" do
      expect(clq.save).to be_true

    end

    it "should contain required data" do
      expect(clq).to respond_to :answer
      expect(clq).to respond_to :comment
      expect(clq).to respond_to :question
      expect(clq).to respond_to :sequence
      expect(clq).to respond_to :declaration
      expect(clq).to respond_to :is_unanswered?

      expect(clq.answer).to be_kind_of String
      expect(clq.comment).to be_kind_of String
      expect(clq.question).to be_kind_of String
      expect(clq.sequence).to be_kind_of Fixnum

      expect(clq).to respond_to :organization
    end
  end
end
