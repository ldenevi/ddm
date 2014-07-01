# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cfsi_declaration, :class => 'Cfsi::Declaration' do
    address "MyString"
    authorized_company_representative_name "MyString"
    company_name "MyString"
    company_unique_identifier "MyString"
    completion_at "2014-05-05 13:42:43"
    contact_email "MyString"
    contact_phone "MyString"
    contact_title "MyString"
    declaration_scope "MyString"
    description_of_scope "MyString"
    language "MyString"
    version "MyString"
  end
end
