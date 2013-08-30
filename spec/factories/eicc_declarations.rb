# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :eicc_declaration, :class => 'Eicc::Declaration' do
    client_id 1
    task_id 1
    gsp_template_input_at "2013-08-24 01:28:08"
    validation_status "MyString"
    language "MyString"
    completion_at "2013-08-24 01:28:08"
    invalid_reasons "MyText"
    company_name "MyString"
    declaration_scope "MyText"
    description_of_scope "MyText"
    company_unique_identifier "MyString"
    address "MyString"
    authorized_company_representative_name "MyString"
    representative_title "MyString"
    representative_email "MyString"
    representative_phone "MyString"
  end
end
