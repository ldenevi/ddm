require 'spec_helper'

describe Cfsi::SmeltersReferenceController do
  let(:srci) { Cfsi::SmeltersReferenceController.new }
  let(:uploaded_list) {
    file_path = File.join(File.dirname(__FILE__), "sample_data", "smelter_references.csv")
    ActionDispatch::Http::UploadedFile.new(:tempfile => File.new(file_path), :filename => File.basename(file_path), :content_type => 'text/csv')
  }

  context "during HTTP requests" do
    render_views

    it "should list all SmelterReferences" do
      get :list
      expect(response).to be_success
      expect(srci.list).to be_kind_of Array
      expect(response.body).to match 'id="csv_upload_form"'
    end
    it "should update SmelterReferences from CSV file" do
      expect { post :update, :csv => uploaded_list }.to change { Cfsi::Reports::SmelterReference.count }.by_at_least(100)
      expect(response).to redirect_to :action => :list
    end
  end

end
