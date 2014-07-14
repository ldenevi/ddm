# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cfsi_reports_smelter_reference, :class => 'Cfsi::Reports::SmelterReference' do
    metal "Gold"
    country "Australia"
    standard_name "Western Australian Mint trading as The Perth Mint"
    key_terms ["Perth", "Australian", "AGR", "Matthey"]
    v2_smelter_id "1AUS046"
    v3_smelter_id "CID002030"
  end
end
