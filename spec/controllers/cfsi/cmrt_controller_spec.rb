require 'spec_helper'

describe Cfsi::CmrtController do
  context "during HTTP requests" do
    it "should have an index list of ValidationsBatches" do
      get :index
      expect(response.status).to eq 200
    end
    it "should create a new ValidationsBatch" do
      post :new
      expect(response).to redirect_to :show
    end
    it "should show a ValidationsBatch" do
      get :show, :id => 1
      expect(response.status).to eq 200
    end
    it "should validate a CMRT" do
      post :validate_cmrt, :spreadsheet => SDFSDFDSF, :batch_id => 1
    end
  end


  context "while using Internet Explorer 9 or below" do
    ZIP_FILEPATH = File.join(Rails.root, 'spec/controllers/cfsi/zipped_declarations.zip')

    it "should not have any Cfsi::ValidationsBatch for testing" do
      Cfsi::ValidationsBatch.destroy_all
      expect(Cfsi::ValidationsBatch.count).to eq 0
    end

    let(:uploaded_file) do
     filepath = File.join(Rails.root, 'spec/controllers/cfsi/zipped_declarations.zip')
     file     = File.open(filepath)
     uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(filepath), :content_type => 'application/vnd.ms-excel')
    end

    it "should accept and unpack zip file containing CFSI reports" do
      Cfsi::ValidationsBatch.destroy_all
      request.env["HTTP_REFERER"] = "/"
      expect { post("upload_zip", :zip => uploaded_file) }.to change{Cfsi::ValidationsBatch.count}.from(0).to(34)
    end
  end
end
