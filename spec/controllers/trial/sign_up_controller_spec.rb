require 'spec_helper'

describe Trial::SignUpController do

  describe "GET 'form'" do
    it "returns http success" do
      get 'form'
      response.should be_success

    end
  end

  describe "GET 'register_new_user'" do
    it "returns http success" do
      get 'register_new_user'
      response.should be_success
    end
  end

  describe "GET 'already_registered'" do
    it "returns http success" do
      get 'already_registered'
      response.should be_success
    end
  end

  describe "GET 'welcome'" do
    it "returns http success" do
      get 'welcome'
      response.should be_success
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
