require 'spec_helper'

describe GSP::Protocols::Regulations::CFSI::Reports::Excel::AggregatedSmelters do
  let(:user) { FactoryGirl.create(:user) }
  let(:org)  { FactoryGirl.create(:organization) }
  let(:batch) do
    b = Cfsi::ValidationsBatch.new :user => user, :organization => org
    b.cmrt_validations = [Cfsi::CmrtValidation.generate(File.join(Rails.root, 'spec', 'models', 'cfsi', 'sample_cmrts', '2.03a', '2.03a_-_green.xlsx'), :user => user, :organization => org),
                          Cfsi::CmrtValidation.generate(File.join(Rails.root, 'spec', 'models', 'cfsi', 'sample_cmrts', '3.01', '3.01_-_validation_needed.xlsx'), :user => user, :organization => org)]
    b.cmrt_validations.each { |val| val.transition_to_opened; val.transition_to_validated }
    b
  end
  let(:asi) { GSP::Protocols::Regulations::CFSI::Reports::Excel::AggregatedSmelters.new batch }

  it "should respond to #aggregated_smelters" do
    expect(asi).to respond_to :aggregated_smelters
    expect(asi.aggregated_smelters).to be_kind_of Hash
    expect(asi.aggregated_smelters).not_to be_empty
  end
end
