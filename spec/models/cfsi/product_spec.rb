require 'spec_helper'

describe Cfsi::Product do
  let(:org)  { FactoryGirl.create(:organization) }
  let(:p) { Cfsi::Product.new :organization => org }

  it "should have required attributes" do
    [:item_number, :item_name, :comment, :declaration].each do |attr|
      expect(p).to respond_to attr
    end
    expect(p).to respond_to :organization
  end
end
