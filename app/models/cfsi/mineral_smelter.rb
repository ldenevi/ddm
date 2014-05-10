class Cfsi::MineralSmelter < ActiveRecord::Base
  belongs_to :declaration
  attr_accessible :comment, :facility_contact_email, :facility_contact_name,
                  :facility_location_city, :facility_location_country,
                  :facility_location_province, :facility_location_street_address,
                  :line_number, :metal, :mineral_source, :mineral_source_location,
                  :proposed_next_steps, :smelter_id, :smelter_reference_list,
                  :standard_smelter_name
end
