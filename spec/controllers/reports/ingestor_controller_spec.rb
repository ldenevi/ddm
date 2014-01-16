require 'spec_helper'

describe Reports::IngestorController do
  describe "Consolidated Smelters" do
    it "should exists" do
      get 'consolidated_smelters', :id => 1
      response.should be_success
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
