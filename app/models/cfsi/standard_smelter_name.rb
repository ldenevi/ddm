class Cfsi::StandardSmelterName < ActiveRecord::Base
  belongs_to :declaration
  attr_accessible :facility_location_country, :known_alias, :metal, :smelter_id, :standard_smelter_name
end
