require "spec_helper"

describe Notifications::Reviews do
  describe "deploy" do
    let(:mail) { Notifications::Reviews.deploy_test(Review.new :name => "Test") }

    it "renders the headers" do
      mail.subject.should eq("[TEST] Review Test deployed")
      mail.to.should eq(["leo.denevi@greenstatuspro.com"])
      mail.from.should eq(["review@greenstatuspro.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("E-Mail test")
    end
  end

end
