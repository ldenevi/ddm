# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cfsi_cmrt_validation, :class => 'Cfsi::CmrtValidation' do
    cmrt nil
    email_sent_at "2014-06-08 20:28:01"
    issues "MyText"
    sent_emails_count 1
    status "MyString"
    validation_attempt 1
    validations_batch nil
    vendor ""
  end
end
