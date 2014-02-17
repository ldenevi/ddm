# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :confirmed_smelter, :class => 'Eicc::ConfirmedSmelter' do
    type ""
    standard_smelter_id "MyString"
    smelter_name "MyString"
    locations "MyString"
    invalid_at "2014-02-16 16:32:58"
    conflict_mineral_policy_url "MyString"
    user nil
  end
end
