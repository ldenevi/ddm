require 'spec_helper'

describe Reports::RoadmapController do
  before(:each) do
    sign_in FactoryGirl.create(:admin)
  end

  context "from Ingestor data" do

    let(:batch) do
      batch = Eicc::BatchValidationStatus.create.from_xml File.read(File.join(File.dirname(__FILE__), "ingestor_batch.xml"))
      batch.update_attribute(:user_id, subject.current_user.id)
      batch
    end

    it "should have current_user" do
      subject.current_user.should_not be_nil
    end

    describe "Comprehensive Due Diligence report" do
      it "should exist and produce a PDF" do
        get 'comprehensive_due_diligence', :id => batch.id
        response.should be_success
        response.header['Content-Type'].should eq "application/pdf"
      end
    end

  end

end
