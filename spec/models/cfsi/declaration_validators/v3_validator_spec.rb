require 'spec_helper'

describe Cfsi::Declaration::V3Validator do
  let(:version_3) do
    dec = Cfsi::Declaration.new :version => '3.01'
    dec.minerals_questions << Cfsi::MineralsQuestion.new(:sequence => 0, :tantalum => "Yes", :tin => "Yes", :gold => "Yes", :tungsten => "Yes")
    dec.minerals_questions << Cfsi::MineralsQuestion.new(:sequence => 1, :tantalum => "Yes", :tin => "Yes", :gold => "Yes", :tungsten => "Yes")
    dec.minerals_questions << Cfsi::MineralsQuestion.new(:sequence => 2, :tantalum => "Yes", :tin => "Yes", :gold => "Yes", :tungsten => "Yes")
    dec.minerals_questions << Cfsi::MineralsQuestion.new(:sequence => 3, :tantalum => "Yes", :tin => "Yes", :gold => "Yes", :tungsten => "Yes")
    dec.minerals_questions << Cfsi::MineralsQuestion.new(:sequence => 4, :tantalum => "Yes", :tin => "Yes", :gold => "Yes", :tungsten => "Yes")
    dec.minerals_questions << Cfsi::MineralsQuestion.new(:sequence => 5, :tantalum => "Yes", :tin => "Yes", :gold => "Yes", :tungsten => "Yes")
    dec.minerals_questions << Cfsi::MineralsQuestion.new(:sequence => 6, :tantalum => "Yes", :tin => "Yes", :gold => "Yes", :tungsten => "Yes")
    validator = Cfsi::Declaration::V3Validator.new(:declaration => dec)
    validator.load_messages
    validator
  end
  let(:loaded_messages) { version_3.messages }

  it "should have required attributes" do
    expect(version_3).to respond_to :messages
    expect(version_3).to respond_to :declaration
    # Declaration sections
    expect(version_3).to respond_to :basic
    expect(version_3).to respond_to :minerals
    expect(version_3).to respond_to :company_level
    expect(version_3).to respond_to :smelters_list
    expect(version_3).to respond_to :standard_smelter_names
  end

  it "should have messages" do
    expect(version_3.messages).to be_kind_of Hash
    expect(version_3.messages).not_to be_empty
  end

  it "should validate basic data" do
    expect(version_3).to respond_to :validate_basic_fields
    version_3.validate_basic_fields
    expect(version_3.basic).to include loaded_messages[:declaration][:no_presence][:company_name]
    expect(version_3.basic).to include loaded_messages[:declaration][:no_presence][:declaration_scope]
    expect(version_3.basic).to include loaded_messages[:declaration][:no_presence][:contact_name]
    expect(version_3.basic).to include loaded_messages[:declaration][:no_presence][:contact_email]
    expect(version_3.basic).to include loaded_messages[:declaration][:no_presence][:contact_phone]
    expect(version_3.basic).to include loaded_messages[:declaration][:no_presence][:authorizer]
    expect(version_3.basic).to include loaded_messages[:declaration][:no_presence][:authorizer_email]
    expect(version_3.basic).to include loaded_messages[:declaration][:no_presence][:authorizer_phone]
    expect(version_3.basic).to include loaded_messages[:declaration][:no_presence][:effective_date]
    expect(version_3.basic).to include "(#{version_3.declaration.language}): " + loaded_messages[:declaration][:no_presence][:language]
  end

  it "should validate if minerals questions are present" do
    expect(version_3).to respond_to :is_in_scope?
    version_3.declaration.minerals_questions = []
    version_3.is_in_scope?
    expect(version_3.minerals).to include loaded_messages[:declaration][:no_presence][:mineral_questions]
  end

  it "should validate minerals data" do
    expect(version_3).to respond_to :validate_minerals_fields
  end

  it "should validate company level data" do
    expect(version_3).to respond_to :validate_company_level_fields
    version_3.declaration.company_level_questions << Cfsi::CompanyLevelQuestion.new
    version_3.validate_company_level_fields
    expect(version_3.company_level).to include loaded_messages[:declaration][:no_presence][:company_level_questions] % 'A'
  end

  it "should cross validate declared minerals and smelters" do
    expect(version_3).to respond_to :cross_validate_minerals_and_smelters
    expect(version_3.is_in_scope?).to be_true
    # Declare a mineral without including mineral smelter
    version_3.cross_validate_minerals_and_smelters
    expect(version_3.basic).to include loaded_messages[:cross_check][:minerals_and_smelters][:flagged][:declared_mineral_and_no_mineral_smelter][:gold]
  end

  it "should validate smelter list" do
    expect(version_3).to respond_to :validate_mineral_smelters
    # List a smelter with empty standard smelter name
    version_3.declaration.mineral_smelters << Cfsi::MineralSmelter.new
    version_3.validate_mineral_smelters
    expect(version_3.smelters_list).to include loaded_messages[:smelters_list][:no_presence][:metal] % 5
    expect(version_3.smelters_list).to include loaded_messages[:smelters_list][:flagged][:required_fields_missing] % [5, 'Metal, Smelter Reference List, Smelter Name, Smelter Country']
  end

  it "should validate products list" do
    expect(version_3).to respond_to :cross_validate_basic_and_products
    version_3.declaration.declaration_scope = "B. Product (or List of Products)"
    version_3.cross_validate_basic_and_products
    expect(version_3.products_list).to include loaded_messages[:cross_check][:products_list][:flagged][:declaration_of_scope_is_product_and_empty_product_list]
  end

end
