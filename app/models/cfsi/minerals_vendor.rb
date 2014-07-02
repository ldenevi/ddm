class Cfsi::MineralsVendor < Vendor

  belongs_to :organization
  attr_accessible :organization
  validate :organization, :presence => true

  def cfsi_confirmed_at
    properties[:cfsi_confirmed_at]
  end

  def minerals
    properties[:minerals]
  end

  def query_match_data
    properties[:query_match_data]
  end
end
