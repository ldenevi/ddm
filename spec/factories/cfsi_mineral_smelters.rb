# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cfsi_mineral_smelter, :class => 'Cfsi::MineralSmelter' do
    comment "MyText"
    declaration nil
    facility_contact_email "MyString"
    facility_contact_name "MyString"
    facility_location_city "MyString"
    facility_location_country "MyString"
    facility_location_province "MyString"
    facility_location_street_address "MyString"
    line_number 1
    metal "MyString"
    mineral_source "MyString"
    mineral_source_location "MyString"
    proposed_next_steps "MyText"
    smelter_id "MyString"
    smelter_reference_list "MyString"
    standard_smelter_name "MyString"
  end
end
