require 'spec_helper'

describe Cfsi::ReportsController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in FactoryGirl.create(:user)
  end
  let(:batch) do
    b = Cfsi::ValidationsBatch.create :user => subject.current_user, :organization => subject.current_user.organization
    b.cmrt_validations = [Cfsi::CmrtValidation.generate(File.join(Rails.root, 'spec', 'models', 'cfsi', 'sample_cmrts', '3.01', '3.01_-_green.xlsx'), :user => subject.current_user, :organization => subject.current_user.organization)]
    b.cmrt_validations.each { |val| val.transition_to_opened; val.transition_to_validated }
    b
  end

  context "during HTTP requests" do
    it "respond to GET aggregated_declarations" do
      get :aggregated_declarations, :batch_id => batch.id
      expect(response.status).to eq 200
      response.header['Content-Type'].should eq "application/excel"
    end
    it "respond to GET consolidated_smelters" do
      get :consolidated_smelters, :batch_id => batch.id
      expect(response.status).to eq 200
      response.header['Content-Type'].should eq "application/excel"
    end
  end
end
