# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cfsi_company_level_question, :class => 'Cfsi::CompanyLevelQuestion' do
    add_attribute :sequence, 1
    question "MyString"
    answer "MyText"
    comment "MyText"
  end
end
