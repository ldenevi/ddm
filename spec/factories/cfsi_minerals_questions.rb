# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cfsi_minerals_question, :class => 'Cfsi::MineralsQuestion' do
    sequence ""
    question "MyString"
    declaration nil
    gold "MyString"
    gold_comment "MyString"
    tantalum "MyString"
    tantalum_comment "MyString"
    tin "MyString"
    tin_comment "MyString"
    tungsten "MyString"
    tungsten_comment "MyString"
  end
end
