require 'spec_helper'

describe GSP::Ext::Ruby do
  let(:array) { [61.8, 48, 8.57, 20.49, 27, 78, 35, 47.24, 16.76, 53, 49, "String", 82.94, 14, 50, 91, 3, [], 14.77, 90, 60, 85.98, 61, 69, 6, 67] }

  context "Array" do
    context "numbers" do
      it "should select numerics" do
        expect(array).to respond_to :select_numerics
        expect(array.select_numerics).to eq [61.8, 48, 8.57, 20.49, 27, 78, 35, 47.24, 16.76, 53, 49, 82.94, 14, 50, 91, 3, 14.77, 90, 60, 85.98, 61, 69, 6, 67]
      end

      it "should average out all content numbers" do
        expect(array).to respond_to :average
        expect(array.average).to eq 43.82884615384615   # Decimal precision may depend on what machine this test runs on
      end
    end
  end
end
