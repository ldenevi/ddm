require 'spec_helper'

describe Roadmap::ReportsController do

  describe "GET 'comprehensive_due_diligence'" do
    it "returns http success" do
      get 'comprehensive_due_diligence'
      response.should be_success
    end
  end

end
