class Eicc::SmelterList < ActiveRecord::Base
  attr_accessible :comment, :declaration_id, :facility_contact_email, :facility_contact_name, :facility_location_city,
                  :facility_location_country, :facility_location_province, :facility_location_street_address, :line_number,
                  :metal, :mineral_source, :mineral_source_location, :proposed_next_steps, :smelter_id, :smelter_reference_list,
                  :standard_smelter_name
                  
  # validates :metal, :smelter_reference_list, :standard_smelter_name, :facility_location_country, :presence => true
  
  
  def to_s
    {:@metal => @metal, :@standard_smelter_name => @standard_smelter_name, :@smelter_reference_list => @smelter_reference_list, :@smelter_id => @smelter_id}.inspect
  end
end
