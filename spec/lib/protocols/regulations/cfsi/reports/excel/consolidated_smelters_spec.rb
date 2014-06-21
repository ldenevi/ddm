require 'spec_helper'

describe GSP::Protocols::Regulations::CFSI::Reports::Excel::ConsolidatedSmelters do
  let(:cs) { GSP::Protocols::Regulations::CFSI::Reports::Excel::ConsolidatedSmelters }
  let(:batch) do
    b = Cfsi::ValidationsBatch.new
    b.cmrt_validations = [Cfsi::CmrtValidation.generate(File.join(Rails.root, 'spec', 'models', 'cfsi', 'sample_cmrts', '2.03a', '2.03a_-_green.xlsx')),
                          Cfsi::CmrtValidation.generate(File.join(Rails.root, 'spec', 'models', 'cfsi', 'sample_cmrts', '3.01', '3.01_-_validation_needed.xlsx'))]
    b.cmrt_validations.each { |val| val.transition_to_opened; val.transition_to_validated }
    b
  end
  let(:csi) { GSP::Protocols::Regulations::CFSI::Reports::Excel::ConsolidatedSmelters.new batch }

  it "should respond to #definition" do
    expect(csi).to respond_to :definition
    expect(csi.definition).to be_kind_of String
    expect(csi.definition).to match /1\) ALL REPORTED SMELTERS/
    expect(csi.definition).to match /2\) CONSOLIDATED SMELTER REPORT/
    expect(csi.definition).to match /3\) CORRECTIVE ACTION REPORT/
    expect(csi.definition).to match /4\) SMELTER COMPLIANCE STATUS REPORT/
    expect(csi.definition).to match /5\) REJECTED ENTRIES/
    expect(csi.definition).to match /6\) AGGREGATED DECLARATIONS/
    expect(csi.definition).to match /7\) SMELTERS BY SUPPLIER LIST/
    expect(csi.definition).to match /8\) COMPREHENSIVE SUPPLIERS VALIDATION/
  end

  it "should have required attributes" do
    [{:name => :validations_batch, :type => Cfsi::ValidationsBatch },
     {:name => :standard_sort, :type => Proc },
     {:name => :worksheets, :type => Array },
     {:name => :mineral_sort_order, :type => Array },
     {:name => :valid_non_smelter_id_sort_order, :type => Array },
     {:name => :rejected_entries_sort, :type => Proc },
     {:name => :sorted_smelters, :type => Array }].each do |attr|
      expect(csi).to respond_to attr[:name]
      expect(csi.send(attr[:name])).to be_kind_of attr[:type]
    end
    expect(csi).to respond_to :is_valid_smelter_id?
    expect(csi.is_valid_smelter_id?("SOMEID")).to be_false
    expect(csi).to respond_to :is_valid_non_smelter_id?
    expect(csi.is_valid_non_smelter_id?("UNKNOWN")).to be_true
  end

  it "should respond to #all_reported_smelters" do
    expect(csi).to respond_to :all_reported_smelters
    expect(csi.all_reported_smelters).to be_kind_of Hash
    expect(csi.all_reported_smelters.keys).to include :name
    expect(csi.all_reported_smelters[:name]).to eq "All Reported Smelters"
    expect(csi.all_reported_smelters.keys).to include :header
    expect(csi.all_reported_smelters[:header]).not_to be_empty
    expect(csi.all_reported_smelters.keys).to include :column_widths
    expect(csi.all_reported_smelters[:column_widths]).not_to be_empty
    expect(csi.all_reported_smelters.keys).to include :data
    expect(csi.all_reported_smelters[:data]).not_to be_empty
  end

  it "should respond to #consolidated_smelters" do
    expect(csi).to respond_to :consolidated_smelters
    expect(csi.consolidated_smelters).to be_kind_of Hash
    expect(csi.consolidated_smelters.keys).to include :name
    expect(csi.consolidated_smelters[:name]).to eq "Consolidated Smelters"
    expect(csi.consolidated_smelters.keys).to include :header
    expect(csi.consolidated_smelters[:header]).not_to be_empty
    expect(csi.consolidated_smelters.keys).to include :column_widths
    expect(csi.consolidated_smelters[:column_widths]).not_to be_empty
    expect(csi.consolidated_smelters.keys).to include :data
    expect(csi.consolidated_smelters[:data]).not_to be_empty
  end

  it "should respond to #rejected_entries" do
    expect(csi).to respond_to :rejected_entries
    expect(csi.rejected_entries).to be_kind_of Hash
    expect(csi.rejected_entries.keys).to include :name
    expect(csi.rejected_entries[:name]).to eq "Rejected Entries"
    expect(csi.rejected_entries.keys).to include :header
    expect(csi.rejected_entries[:header]).not_to be_empty
    expect(csi.rejected_entries.keys).to include :column_widths
    expect(csi.rejected_entries[:column_widths]).not_to be_empty
    expect(csi.rejected_entries.keys).to include :data
    csi.validations_batch.cmrt_validations.first.cmrt.declaration.mineral_smelters.first.standard_smelter_name = ""
    csi.validations_batch.cmrt_validations.first.cmrt.declaration.mineral_smelters.first.facility_location_country = ""
    csi.consolidated_smelters
    expect(csi.rejected_entries[:data]).not_to be_empty
  end

  it "should respond to #cfsi_compliant_smelter_list" do
    expect(csi).to respond_to :cfsi_compliant_smelter_list
    expect(csi.cfsi_compliant_smelter_list).to be_kind_of Hash
    expect(csi.cfsi_compliant_smelter_list.keys).to include :name
    expect(csi.cfsi_compliant_smelter_list[:name]).to eq "CFSI-Compliant Smelters List"
    expect(csi.cfsi_compliant_smelter_list.keys).to include :header
    expect(csi.cfsi_compliant_smelter_list[:header]).not_to be_empty
    expect(csi.cfsi_compliant_smelter_list.keys).to include :column_widths
    expect(csi.cfsi_compliant_smelter_list[:column_widths]).not_to be_empty
    expect(csi.cfsi_compliant_smelter_list.keys).to include :data
    expect(csi.cfsi_compliant_smelter_list[:data]).not_to be_empty
  end

  it "should respond to #smelter_compliance_status" do
    expect(csi).to respond_to :smelter_compliance_status
    expect(csi.smelter_compliance_status).to be_kind_of Hash
    expect(csi.smelter_compliance_status.keys).to include :name
    expect(csi.smelter_compliance_status[:name]).to eq "Smelter Compliance Status"
    expect(csi.smelter_compliance_status.keys).to include :header
    expect(csi.smelter_compliance_status[:header]).not_to be_empty
    expect(csi.smelter_compliance_status.keys).to include :column_widths
    expect(csi.smelter_compliance_status[:column_widths]).not_to be_empty
    expect(csi.smelter_compliance_status.keys).to include :data
  end

  it "should respond to #to_excel" do
    expect(csi).to respond_to :to_excel
  end
end
