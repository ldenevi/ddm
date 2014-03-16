require 'spec_helper'

describe Trial::OrganizationController do


  context "as Trial::TrialUser" do
    it "should display Test Organization Create form" do
      get 'new'
    end

    before(:each) { sign_in Trial::TrialUser.create :email => "test@org.com", :password => "password1" }

    it "should be able to create an organization" do
      request.env["HTTP_REFERER"] = "/trial/organization/new"
      post 'create', :full_name => "Test Organization, Inc.", :display_name => "Test"
      response.should be_success
    end

    it "should redirect back to form if Organization is not valid" do
      request.env["HTTP_REFERER"] = "/trial/organization/new"
      post 'create', :full_name => '', :display_name => ''
      expect(response).to redirect_to :action => :new
    end
  end
end
