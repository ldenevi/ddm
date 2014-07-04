require 'spec_helper'

describe Organization do
  let(:org) { FactoryGirl.create :organization }

  context "(in general)" do
    it "should have required attributes" do
      expect(org).to respond_to :name
      expect(org.name).to be_kind_of String
      expect(org).not_to respond_to :full_name
      expect(org).to respond_to :display_name
      expect(org.display_name).to be_kind_of String
      expect(org).to respond_to :logo
      expect(org).to respond_to :properties
      expect(org.properties).to be_kind_of Hash
    end

    it "should have a name with at least five characters" do
      expect(org.name.size).to be >= 5
    end
  end

  context "as a tree" do
    it "should respond to required tree attributes" do
      expect(org).to respond_to :parent
      expect(org).to respond_to :root_parent
      expect(org).to respond_to :leaves
      expect(org).to respond_to :parent
      expect(org).to respond_to :set_root_parent
      expect(org).to respond_to :set_tree_position
    end
  end
end
