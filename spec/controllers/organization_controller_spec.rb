require 'spec_helper'

describe OrganizationController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'hierarchy'" do
    it "returns http success" do
      get 'hierarchy'
      response.should be_success
    end
  end

  describe "GET 'overview'" do
    it "returns http success" do
      get 'overview'
      response.should be_success
    end
  end

end
