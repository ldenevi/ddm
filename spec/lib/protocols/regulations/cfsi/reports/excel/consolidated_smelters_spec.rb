require 'spec_helper'

describe GSP::Protocols::Regulations::CFSI::Reports::Excel::ConsolidatedSmelters do
  before(:all) do
    Cfsi::Reports::SmelterReference.destroy_all
    Cfsi::Reports::SmelterReference.import_from_csv_file_path(File.join('spec', 'models', 'cfsi', 'reports', 'sample_data', 'smelter_references.csv'))
    Cfsi::ConfirmedSmelter.destroy_all
  end


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
    # expect(csi.consolidated_smelters[:data]).not_to be_empty
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
    # expect(csi.rejected_entries[:data]).to be_empty
    expect(csi).to respond_to :rejected_entries_worksheet
    expect(csi.rejected_entries_worksheet(Axlsx::Workbook.new)).to be_kind_of Axlsx::Worksheet
  end

  it "should create 'Smelter Compliance Status' worksheet" do
    expect(csi).to respond_to :smelter_compliance_statuses
    expect(csi.smelter_compliance_statuses).to be_kind_of Hash
    expect(csi.smelter_compliance_statuses[:name]).to eq 'Smelter Compliance Statuses'
    expect(csi.smelter_compliance_statuses[:header]).not_to be_empty
    # expect(csi.smelter_compliance_statuses[:data]).to be_empty
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

  let(:smelters) do
    smelters_data = File.read(File.join(File.dirname(__FILE__), 'sample_data', 'smelters.csv')).force_encoding("windows-1251").encode("utf-8")
    data = CSV.new(smelters_data).to_a
    smelters = []
    data[1..-1].each do |row|
      smelters << Cfsi::MineralSmelter.new({:metal => row[0], :smelter_reference_list => row[1], :standard_smelter_name => row[2], :facility_location_country => row[3],
                                               :smelter_id => row[4], :facility_location_street_address => row[5], :facility_location_city => row[6], :facility_location_province => row[7],
                                               :facility_contact_name => row[8], :facility_contact_email => row[9]})
    end
    smelters
  end

  it "should group smelters" do
    batch = Cfsi::ValidationsBatch.new(:unidentified_cmrt_validations => [Cfsi::CmrtValidation.new(:cmrt => Cfsi::Cmrt.new(:declaration => Cfsi::Declaration.new(:mineral_smelters => smelters)))])
    csr   = GSP::Protocols::Regulations::CFSI::Reports::Excel::ConsolidatedSmelters.new(batch)
    expect(csr.consolidated_smelters[:data].size).to eq 7
    expect(csr.rejected_entries[:data].size).to eq 23
  end

  it "should associate consolidated smelter data only to sourced CMRTs of said smelter" do
    batch = Cfsi::ValidationsBatch.new

    Dir.glob(File.join(File.dirname(__FILE__), 'sample_data', 'consolidated_smelters_worksheet', '*')).each do |cmrt_folder|
      dec = Cfsi::Declaration.generate_from_csv_file_paths Dir.glob(File.join(cmrt_folder, '*'))
      cmrt = Cfsi::Cmrt.new(:declaration => dec)
      spreadsheet = Spreadsheet.new(:filename => cmrt_folder.split('/').last)
      batch.unidentified_cmrt_validations << Cfsi::CmrtValidation.new(:cmrt => cmrt, :spreadsheet => spreadsheet)
    end
    csr = GSP::Protocols::Regulations::CFSI::Reports::Excel::ConsolidatedSmelters.new(batch)

  end
  
  it "should reject entries with incorrect metal" do
    smelters = [Cfsi::MineralSmelter.create({:metal => "Tin", :smelter_reference_list => "Royal Canadian Mint", :standard_smelter_name => "Royal Canadian Mint", :facility_location_country => "CANADA", :smelter_id => "CID001534", :organization => org}),
                Cfsi::MineralSmelter.create({:metal => "Gold", :smelter_reference_list => "Royal Canadian Mint", :standard_smelter_name => "Royal Canadian Mint", :facility_location_country => "CANADA", :smelter_id => "CID001534", :organization => org})]
    dec = Cfsi::Declaration.new :organization => org, :mineral_smelters => smelters, :version => "2.03a"
    cmrt = Cfsi::Cmrt.new :organization => org, :declaration => dec
    batch = Cfsi::ValidationsBatch.new :organization => org, :user => user
    batch.unidentified_cmrt_validations << Cfsi::CmrtValidation.new(:cmrt => cmrt, :organization => org, :user => user)
    csr = GSP::Protocols::Regulations::CFSI::Reports::Excel::ConsolidatedSmelters.new(batch)
    expect(csr.all_reported_smelters[:data].size).to eq 2
    expect(csr.consolidated_smelters[:data].size).to eq 1
    expect(csr.rejected_entries[:data].size).to eq 1
    expect(csr.rejected_entries[:data].first[6]).to eq "Incorrect metal for smelter"
  end
end
