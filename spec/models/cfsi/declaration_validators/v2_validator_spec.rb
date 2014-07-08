require 'spec_helper'

describe Cfsi::Declaration::V2Validator do
  let(:version_2) do
    Cfsi::Declaration::V2Validator.new(:declaration => Cfsi::Declaration.new(:version => '2.00'))
  end
  let(:loaded_messages) { version_2.messages }

  it "should have required attributes" do
    expect(version_2).to respond_to :messages
    expect(version_2).to respond_to :declaration
    # Declaration sections
    expect(version_2).to respond_to :basic
    expect(version_2).to respond_to :minerals
    expect(version_2).to respond_to :company_level
    expect(version_2).to respond_to :smelters_list
    expect(version_2).to respond_to :standard_smelter_names
  end

  it "should have messages" do
    expect(version_2.messages).to be_kind_of Hash
    expect(version_2.messages).not_to be_empty
  end

  it "should validate basic data" do
    expect(version_2).to respond_to :validate_basic_fields
    version_2.validate_basic_fields
    expect(version_2.basic).to include loaded_messages[:declaration][:no_presence][:company_name]
    expect(version_2.basic).to include loaded_messages[:declaration][:no_presence][:declaration_scope]
    expect(version_2.basic).to include loaded_messages[:declaration][:no_presence][:authorized_company_representative_name]
    expect(version_2.basic).to include loaded_messages[:declaration][:no_presence][:representative_email]
    expect(version_2.basic).to include loaded_messages[:declaration][:no_presence][:completion_at]
    expect(version_2.basic).to include "(#{version_2.declaration.language}): " + loaded_messages[:declaration][:no_presence][:language]
  end

  it "should validate minerals data" do
    expect(version_2).to respond_to :validate_minerals_fields
    version_2.validate_minerals_fields
    expect(version_2.minerals).to include loaded_messages[:declaration][:no_presence][:mineral_questions]
  end

  it "should validate company level data" do
    expect(version_2).to respond_to :validate_company_level_fields
    version_2.validate_company_level_fields
    expect(version_2.company_level).to include loaded_messages[:declaration][:no_presence][:company_level_questions]
  end

  it "should cross validate declared minerals and smelters" do
    expect(version_2).to respond_to :cross_validate_minerals_and_smelters
    # Declare a mineral without including mineral smelter
    version_2.declaration.minerals_questions << Cfsi::MineralsQuestion.new(:gold => "Yes")
    version_2.cross_validate_minerals_and_smelters
    expect(version_2.basic).to include loaded_messages[:cross_check][:minerals_question_1][:flagged][:gold]
  end

  it "should validate smelter list" do
    expect(version_2).to respond_to :validate_mineral_smelters
    # List a smelter with empty standard smelter name and smelter reference list 'Smelter not listed'
    version_2.declaration.mineral_smelters << Cfsi::MineralSmelter.new(:smelter_reference_list => "Smelter not listed")
    version_2.validate_mineral_smelters
    expect(version_2.smelters_list).to include loaded_messages[:smelters_list][:no_presence][:standard_smelter_name]
  end

  it "should validate products list" do
    expect(version_2).to respond_to :cross_validate_basic_and_products
    version_2.declaration.declaration_scope = "D. Product Level"
    version_2.cross_validate_basic_and_products
    expect(version_2.products_list).to include loaded_messages[:cross_check][:products_list][:flagged][:declaration_of_scope_is_product_and_empty_product_list]
  end
end
