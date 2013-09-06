require 'spec_helper'

describe Eicc::StandardSmelterName do
  context "(in general)" do
    let(:name) { Eicc::StandardSmelterName.new }
    it "should validate" do
      name.should be_valid
    end
  end
end
