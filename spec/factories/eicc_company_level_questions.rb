# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :eicc_company_level_question, :class => 'Eicc::CompanyLevelQuestion' do
    declaration_id 1
    sequence 1
    question "MyText"
    answer "MyText"
    comment "MyText"
    organization
  end
end
