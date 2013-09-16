# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :eicc_validation_status, :class => 'Eicc::ValidationStatus' do
    type ""
    parent_id 1
    user_id 1
    uploaded_file_path "MyString"
    filename "MyString"
    status "MyString"
    representative_email "MyString"
    message "MyText"
    is_spreadsheet_return_email_sent? false
  end
end
