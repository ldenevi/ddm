# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cfsi_cmrt, :class => 'Cfsi::Cmrt' do
    company_name "MyString"
    declaration nil
    file_extension "MyString"
    file_name "MyString"
    is_latest false
    language "MyString"
    meta_data "MyString"
    spreadsheet nil
    representative_email "MyString"
    version "MyString"
    minerals_vendor nil
  end

  factory :vendor_cmrt, :class => "Cfsi::Cmrt" do
    company_name "Test Company A"
    file_extension "xls"
    file_name "CMRT_Test_Company_A.xls"
    is_latest true
    language "English"
    meta_data "MyString"
    representative_email "app-test@greenstatuspro.com"
    version "2.03a"
  end
end
