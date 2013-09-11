require 'spec_helper'

describe Eicc::DeclarationController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'list'" do
    it "returns http success" do
      get 'list'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end
  
  describe "POST 'upload'" do

    it "can upload a license" do
      filepath = File.join(Rails.root, 'spec/models/eicc/declaration_spec_data/eicc.xls')
      file     = File.open(filepath)
      uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(filepath), :content_type => 'application/vnd.ms-excel')
      
      post :upload, :attachment => uploaded_file
      response.should be_success
    end
  end

end
