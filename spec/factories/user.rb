FactoryGirl.define do
  factory :user, :class => 'User' do
    first_name "Test"
    last_name "User"
    email "test@user.com.ts"
    password "password"
    organization
  end
end
