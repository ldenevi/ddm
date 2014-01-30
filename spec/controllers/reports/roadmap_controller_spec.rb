require 'spec_helper'

describe Reports::RoadmapController do
  before(:each) do
    sign_in FactoryGirl.create(:admin)
  end

  context "from Ingestor data" do

    let(:review) do
      hash = Hash.from_xml(File.read(File.join(File.dirname(__FILE__), "ingestor_batch1.xml")))
      bh = hash["batch_validation_status"].clone
      bh.delete("individual_validation_statuses")
      batch = Eicc::BatchValidationStatus.new bh.merge(:user => subject.current_user)

      hash["batch_validation_status"]["individual_validation_statuses"].each do |ivs|
        ivs_d = ivs.clone
        ivs_d.delete("declaration")
        batch.individual_validation_statuses << Eicc::IndividualValidationStatus.new(ivs_d.merge(:user => subject.current_user))
      end

      batch.save!

      review = batch.generate_review
      review.save
      review
    end

    it "should have current_user" do
      subject.current_user.should_not be_nil
    end

    describe "Comprehensive Due Diligence report" do
      it "should exist and produce a PDF" do
        get 'comprehensive_due_diligence', :id => review.id
        response.should be_success
        response.header['Content-Type'].should eq "application/pdf"
      end
    end

  end

end
