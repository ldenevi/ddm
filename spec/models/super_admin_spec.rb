require 'spec_helper'

describe SuperAdmin do
  let(:sa) { SuperAdmin.create }
  context "(in general)" do
    it "should have a company association" do
      expect(sa).to respond_to :company
    end
  end
end
