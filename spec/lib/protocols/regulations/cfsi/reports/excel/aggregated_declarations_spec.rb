require 'spec_helper'

describe GSP::Protocols::Regulations::CFSI::Reports::Excel::AggregatedDeclarations do
  let(:org)  { FactoryGirl.create(:organization) }
  let(:user) { FactoryGirl.create(:user) }
  let(:vals) do
    vs = []
    Dir.glob(File.join(File.dirname(__FILE__), 'sample_data', 'aggregated_declarations_worksheets', '*')).each do |dir|
      dec = Cfsi::Declaration.generate_from_csv_file_paths(Dir.glob(File.join(dir, '*')))
      dec.save(:validate => false)
      c = Cfsi::Cmrt.new(:declaration => dec, :organization => org)
      c.initialize_attributes_from_declaration(dec)
      c.save
      v = Cfsi::CmrtValidation.new(:cmrt => c, :user => user, :organization => org, :vendor => c.minerals_vendor)
      v.save
      v.transition_to_validated
      vs << v 
    end
    vs
  end
  let(:batch) do
    b = Cfsi::ValidationsBatch.new :organization => org, :user => user
    b.cmrt_validations = vals
    b.save
    b
  end
  let(:asi) { GSP::Protocols::Regulations::CFSI::Reports::Excel::AggregatedDeclarations.new batch }
  
  it "should process 7 declarations of which 5 are unique declarations" do
    expect(batch.cmrt_validations.size).to eq 7
    expect(batch.latest_cmrt_validations.size).to eq 5
  end

  it "should create 'Aggregated Declarations' worksheet" do
    expect(asi).to respond_to :aggregated_declarations
    expect(asi.aggregated_declarations).to be_kind_of Hash
    expect(asi.aggregated_declarations[:name]).to eq 'Aggregated Declarations'
    expect(asi.aggregated_declarations[:header]).not_to be_empty
    expect(asi.aggregated_declarations[:data]).not_to be_empty
    expect(asi).to respond_to :aggregated_declarations_worksheet
    expect(asi.aggregated_declarations_worksheet(Axlsx::Workbook.new)).to be_kind_of Axlsx::Worksheet
  end
  
  pending "should create 'Analytics' worksheet" do
  end
end
