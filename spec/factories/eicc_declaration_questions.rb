# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :valid_minerals_declaration, :class => 'Eicc::DeclarationQuestion' do
    sequence 1
    question "1) Are any of the following metals necessary to the functionality or production of your company's products that it manufactures or contracts to manufacture? (*)"
    tantalum "Yes"
    tantalum_comment "Tantalum in the head"
    tungsten "Yes"
    tungsten_comment "In the joints"
    tin "No"
    tin_comment "Been using aluminum"
    gold "Yes"
    gold_comment "In the teeth"
  end
  
  factory :invalid_minerals_declaration, :class => 'Eicc::DeclarationQuestion' do
    sequence 2
  end
end
