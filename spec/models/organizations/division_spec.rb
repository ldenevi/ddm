require 'spec_helper'

describe Division do
  let(:div) { FactoryGirl.create :division }
  let(:co) { FactoryGirl.create :company }

  context "(in general)" do
    it "should have required attributes" do
      expect(div).to respond_to :admin
      expect(div.admin).not_to be_nil
      expect(div.valid?).to be_true
      expect(div).to respond_to :users
    end

    it "should not create more Divisions than (Company) root_parent_id#division_limit" do
      expect(co.division_limit).to eq 4
      (1..4).to_a.each do |count|
        co.divisions << Division.create(:name => "Division#{count}", :root_parent => co)
      end
      expect(co.divisions.size).to eq 4
      expect(Division.create(:name => "Should not create this", :root_parent => co)).to have(1).error
      expect(co.divisions.size).to eq 4
    end
  end
end
