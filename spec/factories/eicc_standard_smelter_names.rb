# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :eicc_standard_smelter_name, :class => 'Eicc::StandardSmelterName' do
    metal "MyString"
    standard_smelter_name "MyString"
    known_alias "MyString"
    facility_location_country "MyString"
    smelter_id "MyString"
  end
end
