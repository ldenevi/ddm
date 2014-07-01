# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cfsi_minerals_question, :class => 'Cfsi::MineralsQuestion' do
    add_attribute :sequence, 1
    question "MyString"
    gold "MyString"
    gold_comment "MyString"
    tantalum "MyString"
    tantalum_comment "MyString"
    tin "MyString"
    tin_comment "MyString"
    tungsten "MyString"
    tungsten_comment "MyString"
    organization
  end
end
