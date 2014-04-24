# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trial_user, :class => 'Trial::TrialUser' do
    email "trial.user@test.com"
    password "password1"
  end
end
