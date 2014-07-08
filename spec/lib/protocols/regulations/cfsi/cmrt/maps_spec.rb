require 'spec_helper'

describe GSP::Protocols::Regulations::CFSI::CMRT::Maps do
  let(:map) do
    c = Class
    c.send(:include, GSP::Protocols::Regulations::CFSI::CMRT::Maps)
    c.new
  end

  it "should have required methods" do
    expect(map).to respond_to :get_structure_for_version
    %w(2.00 2.01 2.02 2.03 2.03a 3.01).each do |version|
      expect(map.get_structure_for_version(version)).to be_kind_of Hash
      expect(map).to respond_to :get_cell_definitions_for_version
      expect(map.get_cell_definitions_for_version(version)).to be_kind_of Hash
    end
  end
end
