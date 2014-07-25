# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cfsi_mineral_smelter, :class => 'Cfsi::MineralSmelter' do
    comment "Something about this blah blah"
    facility_contact_email "contact@smelter.com"
    facility_contact_name "John Doe"
    facility_location_city ""
    facility_location_country "Australia"
    facility_location_province ""
    facility_location_street_address ""
    line_number 1
    metal "Gold"
    mineral_source ""
    mineral_source_location ""
    proposed_next_steps ""
    smelter_id "1AUS046"
    smelter_reference_list "Perth Mint (Western Australia Mint)"
    standard_smelter_name "Western Australian Mint trading as The Perth Mint"
    organization
  end
end
