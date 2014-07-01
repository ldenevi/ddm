require 'spec_helper'

describe Cfsi::CompliantSmeltersController do
  let(:csci) { Cfsi::CompliantSmeltersController.new }
  let(:uploaded_list) {
    file_path = File.join(File.dirname(__FILE__), "sample_data", "cfsi_compliant_smelters_list.csv")
    ActionDispatch::Http::UploadedFile.new(:tempfile => File.new(file_path), :filename => File.basename(file_path), :content_type => 'text/csv')
  }

  context "during HTTP requests" do
    render_views
    it "should list all ConfirmedSmelters" do
      get :list
      expect(response.status).to eq 200
      expect(csci.list).to be_kind_of Array
      expect(response.body).to match 'id="csv_upload_form"'
    end
    it "should update ConfirmedSmelters with a CSV file" do
      Cfsi::ConfirmedSmelter.destroy_all
      expect(Cfsi::ConfirmedSmelter.count).to eq 0
      post :update, :csv => uploaded_list
      expect(response).to redirect_to :action => :list
      expect(Cfsi::ConfirmedSmelter.count).not_to eq 0
    end
  end
end
