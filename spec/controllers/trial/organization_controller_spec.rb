require 'spec_helper'

describe Trial::OrganizationController do


  context "as Trial::TrialUser" do
    it "should display Test Organization Create form" do
      get 'new'
    end

    before(:each) { sign_in FactoryGirl.create(:trial_user) }

    it "should be able to create an organization" do
      request.env["HTTP_REFERER"] = "/trial/organization/new"
      post 'create', :organization => {:full_name => "Test Organization, Inc.", :display_name => "Test"}
      response.should redirect_to eicc_declaration_index_path
      expect(flash[:notice]).to include("Created Test Organization, Inc.")
    end

    it "should redirect back to form if Organization is not valid" do
      request.env["HTTP_REFERER"] = "/trial/organization/new"
      post 'create', :organization => {:full_name => "", :display_name => ""}
      expect(response).to redirect_to :action => :new
    end
  end
end
