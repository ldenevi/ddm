require 'spec_helper'

describe Trial::SignUpController do

  describe "GET 'form'" do
    it "returns http success" do
      get 'form'
      response.should be_success
    end
  end

  describe "POST 'register_new_user'" do
    it "should proceed to 'Welcome' page on new user with unique domain" do
      post 'register_new_user', {:trial_trial_user => {:email => "new_user@sub.test.com", :password => "password1"}}
      expect(response).to redirect_to :action => 'welcome'
    end

    it "should redirect to 'already_registered' if e-mail contains existing domain" do
      User.create({:email => "user@sub.test.com", :password => "password1"})
      post 'register_new_user', {:trial_trial_user => {:email => "new_user@sub.test.com", :password => "password1"}}
      expect(response).to redirect_to :action => 'already_registered'
    end
  end

  describe "GET 'already_registered'" do
    it "returns http success" do
      get 'already_registered'
      response.should be_success
    end
  end

  describe "GET 'welcome'" do
    it "should redirect to sign up form if requested directly" do
      get 'welcome'
      expect(response).to redirect_to :action => 'form'
    end
  end

  describe "GET 'setup_organizations'" do
    it "returns http success" do
      get 'setup_organizations'
      response.should be_success
    end
  end

  describe "GET 'setup_users'" do
    it "returns http success" do
      get 'setup_users'
      response.should be_success
    end
  end

end
