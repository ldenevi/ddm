require 'spec_helper'

describe Cfsi::CmrtController do
  before(:all) {  Cfsi::ValidationsBatch.destroy_all }
  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    sign_in user
  end
  let(:org) { FactoryGirl.create(:organization) }
  let(:uploaded_cmrt) do
    cmrt_file_path = File.join(File.dirname(__FILE__), "sample_data", "3.01_-_filled.xls")
    ActionDispatch::Http::UploadedFile.new(:tempfile => File.new(cmrt_file_path), :filename => File.basename(cmrt_file_path), :content_type => 'application/vnd.ms-excel')
  end

  context "during HTTP requests" do
    render_views

    it "should have an index list of ValidationsBatches" do
      get :index
      expect(response.status).to eq 200
    end

    it "should create a new ValidationsBatch" do
      post :new
      expect(response).to redirect_to :action => :show, :id => assigns(:validations_batch).id
    end


    it "should show a ValidationsBatch" do
      vb = Cfsi::ValidationsBatch.create :user => subject.current_user, :organization => org
      get :show, :id => vb.id
      expect(response.status).to eq 200
    end
    it "should validate a CMRT" do
      vb = Cfsi::ValidationsBatch.create :user => subject.current_user, :organization => org
      uploaded_cmrt.tempfile.rewind
      post :validate, :spreadsheet => uploaded_cmrt, :batch_id => vb.id
    end
    it "should list a Cfsi::ValidationsBatch's Cfsi::CmrtValidations" do
      vb = Cfsi::ValidationsBatch.create :user => subject.current_user, :organization => org
      expect {
        vb.cmrt_validations = (0...12).to_a.collect { Cfsi::CmrtValidation.create :validations_batch => vb, :user => subject.current_user, :organization => org }
        get :list_validation_statuses, :batch_id => vb.id
      }.to change{Cfsi::CmrtValidation.count}.by_at_least(12)
      expect(response.status).to eq 200
      expect(response.body).to match 'id="cmrt_validations_list"'
    end
    it "should download CMRT spreadsheet" do
      val = Cfsi::CmrtValidation.generate File.join('spec/models/cfsi/sample_cmrts/3.01/3.01_-_green.xlsx'), :user => subject.current_user, :organization => org
      get :download, :id => val.id
    end
  end

  context "(in general)" do
    it "should validate an uploaded CMRT spreadsheet" do
      expect(controller).to respond_to :validate_cmrt
      vb = Cfsi::ValidationsBatch.create :user => subject.current_user, :organization => org
      controller = Cfsi::CmrtController.new
      uploaded_cmrt.tempfile.rewind
      expect(controller.validate_cmrt(uploaded_cmrt, vb.id, subject.current_user)).to be_true
    end
  end

  context "while using Internet Explorer 9 or below" do
    ZIP_FILEPATH = File.join(Rails.root, 'spec/controllers/cfsi/sample_data/zipped_declarations.zip')

    it "should not have any Cfsi::ValidationsBatch for testing" do
      Cfsi::ValidationsBatch.destroy_all
      expect(Cfsi::ValidationsBatch.count).to eq 0
    end

    let(:uploaded_zip) do
     filepath = File.join(Rails.root, 'spec/controllers/cfsi/sample_data/zipped_declarations.zip')
     file     = File.open(filepath)
     uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(filepath), :content_type => 'application/zip')
    end

    it "should accept and unpack zip file containing CFSI reports" do
      request.env["HTTP_REFERER"] = "/"
      vb = Cfsi::ValidationsBatch.create :user => subject.current_user, :organization => org
      uploaded_zip.tempfile.rewind
      expect { post("validate_zip", :zip => uploaded_zip, :batch_id => vb.id) }.to change{Cfsi::CmrtValidation.count}.by_at_least(14)
    end
  end
end
