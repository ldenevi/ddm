require 'spec_helper'

describe User do
  let(:blank) { User.new }
  let(:user) { FactoryGirl.create(:user) }

  context "(in general)" do
    it "should have required attributes" do
      expect(user).to respond_to :display_name
      expect(user).to respond_to :email
      expect(user).to respond_to :first_name
      expect(user).to respond_to :last_name
      expect(user).to respond_to :organization
      expect(user).to respond_to :password
      expect(user).to respond_to :phone
      expect(user).to be_valid
    end

    it "should have helper methods" do
      expect(user).to respond_to :eponym
    end

    it "should have required data" do
      expect(blank).not_to be_valid
    end
  end
end
