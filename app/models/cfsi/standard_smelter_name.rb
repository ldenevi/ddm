class Cfsi::StandardSmelterName < ActiveRecord::Base
  belongs_to :declaration
  attr_accessible :facility_location_country, :known_alias, :metal, :smelter_id, :standard_smelter_name

  belongs_to :organization
  attr_accessible :organization
  validates :organization, :presence => true
end
