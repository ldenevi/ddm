# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :test_co, :class => 'Organization' do
    name "ACME Test"
  end

end
