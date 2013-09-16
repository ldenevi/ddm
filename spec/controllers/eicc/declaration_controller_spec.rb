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
  
  describe "upload and process spreadsheet" do
    let(:uploaded_file) do
      filepath = File.join(Rails.root, 'spec/models/eicc/declaration_spec_data/eicc.xls')
      file     = File.open(filepath)
      uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(filepath), :content_type => 'application/vnd.ms-excel')
    end
    
    let(:user) do
      org = Organization.create
      org.should be_valid
      User.create :first_name => "Test", :email => "test@test.com", :password => "supersecret", :organization => org
    end
    
    let(:parent_validation_status) do
      Eicc::ValidationStatus.create :user => user, :status => "Processing"
    end
    
    it "can upload a license" do
      post :upload, :attachment => uploaded_file
      response.should be_success
    end
    
    it "should process the spreadsheet" do
      user.should be_valid
      parent_validation_status.should be_valid
      post :validate_single_eicc_spreadsheet, :spreadsheet => uploaded_file, :validation_status_id => parent_validation_status.id
    end

  end

end
