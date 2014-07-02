# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cfsi_confirmed_smelter, :class => 'Cfsi::ConfirmedSmelter' do
    invalid_at "2015-07-01 15:29:40"
    locations "Germany"
    mineral "Gold"
    name "Allgemeine Gold-und Silberscheideanstalt A.G."
    source "CFSI"
    status "Confirmed"
    v3_smelter_id "CID000035"
  end
end
