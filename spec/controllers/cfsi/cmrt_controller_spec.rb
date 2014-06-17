require 'spec_helper'

describe Cfsi::CmrtController do
  before(:all) {  Cfsi::ValidationsBatch.destroy_all }
  let(:uploaded_cmrt) do
    cmrt_file_path = File.join(File.dirname(__FILE__), "3.01_-_filled.xls")
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
      vb = Cfsi::ValidationsBatch.create
      get :show, :id => vb.id
      expect(response.status).to eq 200
    end
    it "should validate a CMRT" do
      vb = Cfsi::ValidationsBatch.create
      post :validate, :spreadsheet => uploaded_cmrt, :batch_id => vb.id
    end
    it "should list a Cfsi::ValidationsBatch's Cfsi::CmrtValidations" do
      vb = Cfsi::ValidationsBatch.create
      vb.cmrt_validations = (0...12).to_a.collect { Cfsi::CmrtValidation.create :validations_batch => vb }
      get :list_validation_statuses, :batch_id => vb.id
      expect(Cfsi::CmrtValidation.count).to eq 14
      expect(response.status).to eq 200
      expect(response.body).to match 'id="cmrt_validations_list"'
    end
  end

  context "(in general)" do
    it "should validate an uploaded CMRT spreadsheet" do
      expect(controller).to respond_to :validate_cmrt
      vb = Cfsi::ValidationsBatch.create
      controller = Cfsi::CmrtController.new
      expect(controller.validate_cmrt(uploaded_cmrt, vb.id)).to be_true
    end
  end


  context "while using Internet Explorer 9 or below" do
    ZIP_FILEPATH = File.join(Rails.root, 'spec/controllers/cfsi/zipped_declarations.zip')

    it "should not have any Cfsi::ValidationsBatch for testing" do
      Cfsi::ValidationsBatch.destroy_all
      expect(Cfsi::ValidationsBatch.count).to eq 0
    end

    let(:uploaded_zip) do
     filepath = File.join(Rails.root, 'spec/controllers/cfsi/zipped_declarations.zip')
     file     = File.open(filepath)
     uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(filepath), :content_type => 'application/zip')
    end

    it "should accept and unpack zip file containing CFSI reports" do
      Cfsi::ValidationsBatch.destroy_all
      Cfsi::CmrtValidation.destroy_all
      request.env["HTTP_REFERER"] = "/"
      vb = Cfsi::ValidationsBatch.create
      expect { post("validate_zip", :zip => uploaded_zip, :batch_id => vb.id) }.to change{Cfsi::CmrtValidation.count}.from(0).to(14)
    end
  end
end
