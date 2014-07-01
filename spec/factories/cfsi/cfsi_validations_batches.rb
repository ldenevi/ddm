# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cfsi_validations_batch, :class => 'Cfsi::ValidationsBatch' do
    organization
    user
  end
end
