# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin, :class => 'User' do
    first_name "Test"
    last_name "User"
    email "test@user.com"
    password "password"
    association :organization, :factory => :test_co
  end

  factory :test_co, :class => 'Organization' do
    full_name "ACME Test"
  end

end
