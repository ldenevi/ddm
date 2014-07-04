require 'spec_helper'

describe Company do
  let(:co) { FactoryGirl.create :company }

  context "(in general)" do
    it "should have required attributes" do
      expect(co).to respond_to :superadmin
      expect(co.superadmin).not_to be_nil
      expect(co.valid?).to be_true
      expect(co.superadmin).not_to be_nil
      expect(co).to respond_to :divisions
      expect(co).to respond_to :division_limit
      expect(co.division_limit).to be 4
    end
  end
end
