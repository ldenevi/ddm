# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cfsi_standard_smelter_name, :class => 'Cfsi::StandardSmelterName' do
    facility_location_country "MyString"
    known_alias "MyString"
    metal "MyString"
    smelter_id "MyString"
    standard_smelter_name "MyString"
  end
end
