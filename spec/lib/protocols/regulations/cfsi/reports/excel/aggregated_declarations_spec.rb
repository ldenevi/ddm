require 'spec_helper'

describe GSP::Protocols::Regulations::CFSI::Reports::Excel::AggregatedDeclarations do
  let(:user) { FactoryGirl.create(:user) }
  let(:org)  { FactoryGirl.create(:organization) }
  let(:batch) do
    b = Cfsi::ValidationsBatch.new :user => user, :organization => org
    b.cmrt_validations = [Cfsi::CmrtValidation.generate(File.join(Rails.root, 'spec', 'models', 'cfsi', 'sample_cmrts', '2.03a', '2.03a_-_green.xlsx'), :user => user, :organization => org, :validations_batch => b),
                          Cfsi::CmrtValidation.generate(File.join(Rails.root, 'spec', 'models', 'cfsi', 'sample_cmrts', '3.01', '3.01_-_validation_needed.xlsx'), :user => user, :organization => org, :validations_batch => b)]
    b.cmrt_validations.each { |val| val.transition_to_opened; val.transition_to_validated }
    b
  end
  let(:asi) { GSP::Protocols::Regulations::CFSI::Reports::Excel::AggregatedDeclarations.new batch }

  it "should respond to #aggregated_smelters" do
    expect(asi).to respond_to :aggregated_declarations
    expect(asi.aggregated_declarations).to be_kind_of Hash
    expect(asi.aggregated_declarations).not_to be_empty
  end

  it "should generate a statistics worksheet" do
    expect(asi).to respond_to :statistics
    expect(asi.statistics).to be_kind_of Hash
    expect(asi.statistics).not_to be_empty
    expect(asi).to respond_to :statistics_worksheet
    expect(asi.statistics_worksheet(Axlsx::Workbook.new)).to be_kind_of Axlsx::Worksheet
  end
end