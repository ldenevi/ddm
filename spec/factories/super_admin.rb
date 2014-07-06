FactoryGirl.define do
  factory :superadmin, :class => 'SuperAdmin' do
    first_name "Super"
    last_name "Admin"
    email "superadmin@user.com.ts"
    password "password"
  end
end
