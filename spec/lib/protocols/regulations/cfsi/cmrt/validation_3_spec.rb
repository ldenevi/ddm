require 'spec_helper'

describe GSP::Protocols::Regulations::CFSI::CMRT::Validation do
  context "for version 3.xx" do
    let(:version_3) do
      c = Class.new
      c.extend(GSP::Protocols::Regulations::CFSI::CMRT::Validation::Version3)
      c.declaration = Cfsi::Declaration.new :version => '3.01'
      c.declaration.minerals_questions << Cfsi::MineralsQuestion.new(:sequence => 0, :tantalum => "Yes", :tin => "Yes", :gold => "Yes", :tungsten => "Yes")
      c.declaration.minerals_questions << Cfsi::MineralsQuestion.new(:sequence => 1, :tantalum => "Yes", :tin => "Yes", :gold => "Yes", :tungsten => "Yes")
      c.load_messages
      c.is_in_scope?
      c
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
      expect(version_3.basic).to include loaded_messages[:declaration][:no_presence][:authorized_company_representative_name]
      expect(version_3.basic).to include loaded_messages[:declaration][:no_presence][:representative_email]
      expect(version_3.basic).to include loaded_messages[:declaration][:no_presence][:completion_at]
      expect(version_3.basic).to include "(#{version_3.declaration.language}): " + loaded_messages[:declaration][:no_presence][:language]
    end

    it "should validate minerals data" do
      expect(version_3).to respond_to :validate_minerals_fields
      version_3.declaration.minerals_questions = []
      version_3.validate_minerals_fields
      expect(version_3.minerals).to include loaded_messages[:declaration][:no_presence][:mineral_questions]
    end

    it "should validate company level data" do
      expect(version_3).to respond_to :validate_company_level_fields
      version_3.validate_company_level_fields
      expect(version_3.company_level).to include loaded_messages[:declaration][:no_presence][:company_level_questions]
    end

    it "should cross validate declared minerals and smelters" do
      expect(version_3).to respond_to :cross_validate_minerals_and_smelters
      # Declare a mineral without including mineral smelter
      version_3.cross_validate_minerals_and_smelters
      expect(version_3.basic).to include loaded_messages[:cross_check][:minerals_and_smelters][:flagged][:declared_mineral_and_no_mineral_smelter][:gold]
    end

    it "should validate smelter list" do
      expect(version_3).to respond_to :validate_mineral_smelters
      # List a smelter with empty standard smelter name
      version_3.declaration.mineral_smelters << Cfsi::MineralSmelter.new
      version_3.validate_mineral_smelters
      expect(version_3.smelters_list).to include loaded_messages[:smelters_list][:no_presence][:smelter_reference_list]
    end
  end
end
