class Cfsi::MineralSmelter < ActiveRecord::Base
  belongs_to :declaration
  attr_accessible :comment, :facility_contact_email, :facility_contact_name,
                  :facility_location_city, :facility_location_country,
                  :facility_location_province, :facility_location_street_address,
                  :line_number, :metal, :mineral_source, :mineral_source_location,
                  :proposed_next_steps, :smelter_reference_list,
                  :standard_smelter_name, :v2_smelter_id, :v3_smelter_id

  belongs_to :organization
  attr_accessible :organization
  validates :organization, :presence => true

  def smelter_id=(value)
    if value.to_s.match(/^CID./)
      self.v3_smelter_id = value
      self.v2_smelter_id = ''
    elsif value.to_s.match(/^[0-9][A-Z]{3}/)
      self.v2_smelter_id = value
      self.v3_smelter_id = ''
    else
      self.v2_smelter_id = value.to_s
      self.v3_smelter_id = ''
    end
  end

  def smelter_id
    (self.v3_smelter_id.empty?) ? self.v2_smelter_id : self.v3_smelter_id
  end

  def gsp_standard_name
    @gsp_standard_name ||= Cfsi::Reports::SmelterReference.get_standard_names_for(self).first
  end

  def vendor_key
    [metal, gsp_standard_name, facility_location_country].map(&:to_s).map(&:downcase)
  end
end
