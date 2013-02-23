require "spec_helper"

describe Notification::Reviews do
  describe "deploy" do
    let(:mail) { Notification::Reviews.deploy }

    it "renders the headers" do
      mail.subject.should eq("Deploy")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
