require 'spec_helper'

describe GSP::Protocols::Regulations::CFSI::CMRT::V2ToV3IdTranslation do
  let(:abstract) {
    c = Struct
    c.send(:include, GSP::Protocols::Regulations::CFSI::CMRT::V2ToV3IdTranslation)
    c.new(:v2_smelter_id, :v3_smelter_id)
  }
  let(:v2tov3) {
    abstract.new('1DEU001', nil)
  }

  it "should have required attributes and methods" do
    expect(v2tov3).to respond_to :v2_smelter_id
    expect(v2tov3.v2_smelter_id).to eq '1DEU001'
    expect(v2tov3).to respond_to :v3_smelter_id
    expect(v2tov3.v3_smelter_id).to be_nil
    expect(abstract).to respond_to :translation_table
    expect(abstract).to respond_to :data_csv_exists?
    expect(abstract.data_csv_exists?).to be_true
    expect(abstract).to respond_to :load_data_csv
    expect(abstract.load_data_csv).to be_true
    expect(abstract.translation_table).not_to be_empty
    expect(v2tov3.class.translation_table).to be_kind_of Array
    expect(v2tov3.class.translation_table[0].size).to eq 5 # columns
    expect(abstract).to respond_to :get_v3_smelter_id_from_v2_smelter_id
    expect(abstract.get_v3_smelter_id_from_v2_smelter_id(v2tov3.v2_smelter_id)).to eq 'CID000035'
  end
end
