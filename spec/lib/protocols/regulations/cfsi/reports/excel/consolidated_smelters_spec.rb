require 'spec_helper'

describe GSP::Protocols::Regulations::CFSI::Reports::Excel::ConsolidatedSmelters do
  let(:user) { FactoryGirl.create(:user) }
  let(:org)  { FactoryGirl.create(:organization) }
  let(:batch) do
    b = Cfsi::ValidationsBatch.new :user => user, :organization => org
    b.cmrt_validations = [Cfsi::CmrtValidation.generate(File.join(Rails.root, 'spec', 'models', 'cfsi', 'sample_cmrts', '2.03a', '2.03a_-_green.xlsx'), :user => user, :organization => org, :validations_batch => b),
                          Cfsi::CmrtValidation.generate(File.join(Rails.root, 'spec', 'models', 'cfsi', 'sample_cmrts', '3.01', '3.01_-_validation_needed.xlsx'), :user => user, :organization => org, :validations_batch => b)]
    b.cmrt_validations.each { |val| val.transition_to_opened; val.transition_to_validated }
    b
  end
  let(:csi) { GSP::Protocols::Regulations::CFSI::Reports::Excel::ConsolidatedSmelters.new batch }

  it "should create 'All Reported Smelters' worksheet" do
    expect(csi).to respond_to :all_reported_smelters
    expect(csi.all_reported_smelters).to be_kind_of Hash
    expect(csi.all_reported_smelters[:name]).to eq 'All Reported Smelters'
    expect(csi.all_reported_smelters[:header]).not_to be_empty
    expect(csi.all_reported_smelters[:data]).not_to be_empty
    expect(csi).to respond_to :all_reported_smelters_worksheet
    expect(csi.all_reported_smelters_worksheet(Axlsx::Workbook.new)).to be_kind_of Axlsx::Worksheet
  end

  it "should create 'Consolidated Smelters' worksheet" do
    expect(csi).to respond_to :consolidated_smelters
    expect(csi.consolidated_smelters).to be_kind_of Hash
    expect(csi.consolidated_smelters[:name]).to eq 'Consolidated Smelters'
    expect(csi.consolidated_smelters[:header]).not_to be_empty
    expect(csi.consolidated_smelters[:data]).not_to be_empty
    expect(csi).to respond_to :consolidated_smelters_worksheet
    expect(csi.consolidated_smelters_worksheet(Axlsx::Workbook.new)).to be_kind_of Axlsx::Worksheet
  end

  it "should create 'Rejected Entries' worksheet" do
    expect(csi).to respond_to :rejected_entries
    expect { csi.rejected_entries }.to raise_error
    csi.consolidated_smelters
    expect { csi.rejected_entries }.not_to raise_error
    expect(csi.rejected_entries).to be_kind_of Hash
    expect(csi.rejected_entries[:name]).to eq 'Rejected Entries'
    expect(csi.rejected_entries[:header]).not_to be_empty
    expect(csi.rejected_entries[:data]).to be_empty
    expect(csi).to respond_to :rejected_entries_worksheet
    expect(csi.rejected_entries_worksheet(Axlsx::Workbook.new)).to be_kind_of Axlsx::Worksheet
  end

  it "should create 'Smelter Compliance Status' worksheet" do
    expect(csi).to respond_to :smelter_compliance_statuses
    expect(csi.smelter_compliance_statuses).to be_kind_of Hash
    expect(csi.smelter_compliance_statuses[:name]).to eq 'Smelter Compliance Statuses'
    expect(csi.smelter_compliance_statuses[:header]).not_to be_empty
    expect(csi.smelter_compliance_statuses[:data]).not_to be_empty
    expect(csi).to respond_to :smelter_compliance_statuses_worksheet
    expect(csi.smelter_compliance_statuses_worksheet(Axlsx::Workbook.new)).to be_kind_of Axlsx::Worksheet
  end

  it "should create 'Analytics' worksheet" do
    expect(csi).to respond_to :analytics
    expect(csi.analytics).to be_kind_of Hash
    expect(csi.analytics[:name]).to eq 'Analytics'
    expect(csi.analytics[:rows]).not_to be_empty
    expect(csi).to respond_to :analytics_worksheet
    expect(csi.analytics_worksheet(Axlsx::Workbook.new)).to be_kind_of Axlsx::Worksheet
  end
end
