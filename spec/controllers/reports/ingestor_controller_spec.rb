require 'spec_helper'

describe Reports::IngestorController do
  before(:each) do
    sign_in FactoryGirl.create(:admin)
  end

  let(:batch) do
    batch = Eicc::BatchValidationStatus.create.from_xml File.read(File.join(File.dirname(__FILE__), "ingestor_batch.xml"))
    batch.update_attribute(:user_id, subject.current_user.id)
    batch
  end

  it "should have current_user" do
    subject.current_user.should_not be_nil
  end

  describe "Consolidated Smelters" do
    it "should exist" do
      get 'consolidated_smelters', :id => batch.id
      response.should be_success
      response.header['Content-Type'].should eq "application/excel"
    end
  end

  describe "Aggregated Declarations" do
    it "should exists" do
      get 'aggregated_declarations', :id => 1
      response.should be_success
    end
  end
  describe "Smelters by Suppliers" do
    it "should exists" do
      get 'smelters_by_suppliers', :id => 1
      response.should be_success
    end
  end

end
