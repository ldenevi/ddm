FactoryGirl.define do
  sequence(:email) { |n| "test#{n}@user.com.ts" }
  
  factory :user, :class => 'User' do
    first_name "Test"
    last_name "User"
    email
    password "password"
    organization
  end
  
  factory :admin, :class => 'User' do
    first_name "Test"
    last_name "User"
    email
    password "password"
    association :organization, :factory => :test_co
    confirmed_at Time.now
  end
end
