# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :eicc_user, :class => 'User' do
  end

  factory :batch_run, :class => 'Eicc::BatchValidationStatus' do
    status "Completed"
    is_spreadsheet_return_email_sent false
    user_id 1
  end

  factory :individual_validation_status, :class => 'Eicc::IndividualValidationStatus' do
    sequence 2
  end
end
