# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin, :class => 'User' do
    first_name "Test"
    last_name "User"
    email "test@user.com"
    password "password"
    association :organization, :factory => :test_co
    confirmed_at Time.now
  end

  factory :test_co, :class => 'Organization' do
    name "ACME Test"
  end

end
