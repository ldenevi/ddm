require 'spec_helper'

describe Cfsi::Product do
  let(:p) { Cfsi::Product.new }

  it "should have required attributes" do
    [:item_number, :item_name, :comment, :declaration].each do |attr|
      expect(p).to respond_to attr
    end
  end
end
