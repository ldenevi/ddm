class Cfsi::MineralSmelter < ActiveRecord::Base
  belongs_to :declaration
  attr_accessible :comment, :facility_contact_email, :facility_contact_name,
                  :facility_location_city, :facility_location_country,
                  :facility_location_province, :facility_location_street_address,
                  :line_number, :metal, :mineral_source, :mineral_source_location,
                  :proposed_next_steps, :smelter_reference_list,
                  :standard_smelter_name, :v2_smelter_id, :v3_smelter_id, :smelter_id

  belongs_to :organization
  attr_accessible :organization
  validates :organization, :presence => true

  include GSP::Protocols::Regulations::CFSI::CMRT::V2ToV3IdTranslation
  after_initialize :set_v3_smelter_id_from_v2_smelter_id

  def smelter_id=(value)
    if value.to_s.match(/^CID./)
      self.v3_smelter_id = value.to_s.strip
      self.v2_smelter_id = ''
    elsif value.to_s.match(/^[0-9][A-Z]{3}/)
      self.v2_smelter_id = value.to_s.strip
      self.v3_smelter_id = ''
    else
      self.v2_smelter_id = value.to_s.strip
      self.v3_smelter_id = ''
    end
  end

  def smelter_id
    ((self.v3_smelter_id.empty?) ? self.v2_smelter_id : self.v3_smelter_id).to_s
  end

  def gsp_standard_name
    Cfsi::Reports::SmelterReference.get_standard_names_for(self).first
  end

  def vendor_key
    [metal, gsp_standard_name, facility_location_country].map(&:to_s).map(&:downcase)
  end

  def has_valid_smelter_id?
    !(smelter_id.match(/^[1-4][A-Z]{3}[0-9]{3}$/) || smelter_id.match(/^CID/)).nil?
  end

  def has_valid_non_smelter_id?
    ["not listed", "not supplied", "unknown"].include? smelter_id.downcase
  end

  def does_mineral_match_v2_smelter_id?
    return true if v2_smelter_id.empty?
    ref = {'1' => 'gold', '2' => 'tin', '3' => 'tantalum', '4' => 'tungsten'}
    ref[v2_smelter_id.strip[0]] == metal.strip.downcase
  end

  def has_valid_smelter_name?
    standard_smelter_name.to_s.downcase.split('').uniq.size > 1 && standard_smelter_name.to_s.size > 2
  end

  def has_valid_mineral?
    ["gold", "tin", "tantalum", "tungsten", ""].include?(metal.to_s.downcase)
  end
end
