FactoryGirl.define do
  factory :company, :class => 'Company' do
    name "Test Company, Inc."
    display_name "TC"
    properties :division_limit => 4
    superadmin
  end
end
