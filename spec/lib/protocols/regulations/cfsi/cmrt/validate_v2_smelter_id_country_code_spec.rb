require 'spec_helper'

describe GSP::Protocols::Regulations::CFSI::CMRT::ValidateV2SmelterIdCountryCode do
  let(:abstract) {
    c = Struct
    c.send(:include, GSP::Protocols::Regulations::CFSI::CMRT::ValidateV2SmelterIdCountryCode)
    c.new(:v2_smelter_id)
  }
  let(:invalid_smelter) {
    abstract.new('1CDN123')
  }
  let(:valid_smelter) {
    abstract.new('1CAN123')
  }

  it "should have required attributes and methods" do
    expect(abstract).to respond_to :data_csv_exists?
    expect(abstract).to respond_to :load_data_csv
    expect(invalid_smelter).to respond_to :v2_smelter_id
    expect(invalid_smelter).to respond_to :is_v2_smelter_id_country_code_valid?
    expect(invalid_smelter.is_v2_smelter_id_country_code_valid?).to be_false
    expect(valid_smelter.is_v2_smelter_id_country_code_valid?).to be_true
  end
end
