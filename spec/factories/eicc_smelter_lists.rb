# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :eicc_smelter_list, :class => 'Eicc::SmelterList' do
    declaration_id 1
    line_number 1
    metal "MyString"
    smelter_reference_list "MyString"
    facility_location_country "MyString"
    smelter_id "MyString"
    facility_location_street_address "MyString"
    facility_location_city "MyString"
    facility_location_province "MyString"
    facility_contact_name "MyString"
    facility_contact_email "MyString"
    proposed_next_steps "MyString"
    mineral_source "MyString"
    mineral_source_location "MyString"
    comment "MyText"
  end
end
