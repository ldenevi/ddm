require 'spec_helper'

SAMPLE_CMRT_CSV_DIR_PATH = File.join(File.dirname(__FILE__), "sample_cmrts", "csv_worksheets")

describe Cfsi::Declaration do
  let (:blank_declaration) { Cfsi::Declaration.new :company_level_questions => [Cfsi::CompanyLevelQuestion.new],
                                                     :minerals_questions => [Cfsi::MineralsQuestion.new],
                                                     :mineral_smelters => [Cfsi::MineralSmelter.new],
                                                     :standard_smelter_names => [Cfsi::StandardSmelterName.new]}
  context "test" do
    it "should have a sample CMRT" do
      expect(File.exist?(SAMPLE_CMRT_CSV_DIR_PATH)).to be_true
    end
  end

  context "Exceptions" do
    it "should be able to raise exception on detecting Version 1" do
      expect(GSP::Protocols::Regulations::CFSI::CMRT::Exceptions::VersionOne).to respond_to :new
    end
  end

  context "(in general)" do

    it "should contain required data" do
      [:address, :authorized_company_representative_name, :company_name,
       :company_unique_identifier, :completion_at, :contact_email, :contact_phone,
       :contact_title, :csv_worksheets, :declaration_scope, :description_of_scope,
       :language, :version].each do |attr|
       expect(blank_declaration).to respond_to attr
      end
    end

    it "should contain associations" do
      expect(blank_declaration).to respond_to :company_level_questions
      expect(blank_declaration.company_level_questions.first).to be_kind_of Cfsi::CompanyLevelQuestion
      expect(blank_declaration).to respond_to :minerals_questions
      expect(blank_declaration.minerals_questions.first).to be_kind_of Cfsi::MineralsQuestion
      expect(blank_declaration).to respond_to :mineral_smelters
      expect(blank_declaration.mineral_smelters.first).to be_kind_of Cfsi::MineralSmelter
      expect(blank_declaration.standard_smelter_names.first).to be_kind_of Cfsi::StandardSmelterName
      expect(blank_declaration).to respond_to :standard_smelter_names
    end

    it "should detect version" do
      expect((class << Cfsi::Declaration; self; end)).to include GSP::Protocols::Regulations::CFSI::Versions
      expect(Cfsi::Declaration).to respond_to :get_version
    end

    require 'csv'
    let(:csv_worksheets) { Dir.glob(File.join(SAMPLE_CMRT_CSV_DIR_PATH, "*.csv.*")) }
    let (:generated_declaration) { Cfsi::Declaration.generate_from_csv_file_paths(csv_worksheets) }

    it "should respond to .generate(cmrt_csv_worksheets)" do
      expect(Cfsi::Declaration).to respond_to :generate
      expect(generated_declaration).to be_kind_of Cfsi::Declaration
    end

    it "should generate a fully populated Declaration with populated associations from Worksheet data" do
      expect(generated_declaration.csv_worksheets).not_to be_empty
      expect(generated_declaration.csv_worksheets.first).to be_kind_of GSP::Documents::MsOffice::Excel::Spreadsheet::Worksheet

      # Basic declaration data
      expect(generated_declaration.authorized_company_representative_name).to eq "Leo de Nevi"
      expect(generated_declaration.company_name).to eq "Green Status Pro"
      expect(generated_declaration.contact_email).to eq "leo.denevi@greenstatuspro.com"
      expect(generated_declaration.contact_phone).to eq "555-555-5858"
      expect(generated_declaration.contact_title).to eq "Chief Technology Officer"

      # Minerals questions
      expect(generated_declaration.minerals_questions).not_to be_empty
      expect(generated_declaration.minerals_questions.first).not_to be_nil
      expect(generated_declaration.minerals_questions.first.question).not_to be_empty
      expect(generated_declaration.minerals_questions.first.gold).not_to be_empty
      expect(generated_declaration.minerals_questions.first.tantalum).not_to be_empty
      expect(generated_declaration.minerals_questions.first.tin).not_to be_empty
      expect(generated_declaration.minerals_questions.first.tungsten).not_to be_empty
      expect(generated_declaration.minerals_questions.last).not_to be_nil
      expect(generated_declaration.minerals_questions.last.question).not_to be_empty
      expect(generated_declaration.minerals_questions.last.gold).to be_nil
      expect(generated_declaration.minerals_questions.last.tantalum).not_to be_empty
      expect(generated_declaration.minerals_questions.last.tin).not_to be_empty
      expect(generated_declaration.minerals_questions.last.tungsten).to be_nil

      # Company level questions
      expect(generated_declaration.company_level_questions).not_to be_empty
      expect(generated_declaration.company_level_questions.first).not_to be_nil
      expect(generated_declaration.company_level_questions.first.question).not_to be_empty
      expect(generated_declaration.company_level_questions.first.answer).not_to be_empty
      expect(generated_declaration.company_level_questions.last).not_to be_nil
      expect(generated_declaration.company_level_questions.last.question).not_to be_empty
      expect(generated_declaration.company_level_questions.last.answer).not_to be_empty

      # Smelter list
      expect(generated_declaration.mineral_smelters).not_to be_empty
      expect(generated_declaration.mineral_smelters.first).not_to be_nil
      expect(generated_declaration.mineral_smelters.first.line_number).not_to be_nil
      expect(generated_declaration.mineral_smelters.first.smelter_reference_list).not_to be_empty
      expect(generated_declaration.mineral_smelters.first.metal).not_to be_empty
      expect(generated_declaration.mineral_smelters.last).not_to be_nil
      expect(generated_declaration.mineral_smelters.last.line_number).not_to be_nil
      expect(generated_declaration.mineral_smelters.last.smelter_reference_list).not_to be_empty
      expect(generated_declaration.mineral_smelters.last.metal).not_to be_empty

      # Standard smelter names
      expect(generated_declaration.standard_smelter_names).not_to be_empty
      expect(generated_declaration.standard_smelter_names.first).not_to be_nil
      expect(generated_declaration.standard_smelter_names.first.facility_location_country).not_to be_empty
      expect(generated_declaration.standard_smelter_names.first.known_alias).to be_nil
      expect(generated_declaration.standard_smelter_names.first.metal).not_to be_empty
      expect(generated_declaration.standard_smelter_names.first.smelter_id).not_to be_empty
      expect(generated_declaration.standard_smelter_names.first.standard_smelter_name).not_to be_empty
      expect(generated_declaration.standard_smelter_names.last.facility_location_country).not_to be_empty
      expect(generated_declaration.standard_smelter_names.last.known_alias).not_to be_empty
      expect(generated_declaration.standard_smelter_names.last.metal).not_to be_empty
      expect(generated_declaration.standard_smelter_names.last.smelter_id).not_to be_empty
      expect(generated_declaration.standard_smelter_names.last.standard_smelter_name).not_to be_empty
    end

    let(:declaration_from_csvs) { Cfsi::Declaration.generate_from_csv_file_paths(Dir.glob(File.join(SAMPLE_CMRT_CSV_DIR_PATH, "*.csv.*"))) }
    it "should generate a Declaration from a list of csv worksheet file paths" do
      expect(Cfsi::Declaration).to respond_to :generate_from_csv_file_paths
      expect(declaration_from_csvs).to be_kind_of Cfsi::Declaration
      expect(declaration_from_csvs.csv_worksheets.first).to be_kind_of GSP::Documents::MsOffice::Excel::Spreadsheet::Worksheet
    end
  end

  context "using the new OfficeConv-produced worksheets" do
    let(:unabridged_csv_file_paths) { Dir.glob(File.join(File.dirname(__FILE__), 'sample_cmrts', '2.03', 'unabridged_worksheets', '*')) }
    let(:declaration_from_unabriged_csvs) { Cfsi::Declaration.generate_from_csv_file_paths(unabridged_csv_file_paths) }
    it "should process at the normal speed" do
      expect(unabridged_csv_file_paths).not_to be_empty
      expect(declaration_from_unabriged_csvs).to be_kind_of Cfsi::Declaration
    end
  end

  context "while version 3.00+" do
    it "should have columns for CMRT version 3.00+" do
      [:company_unique_id_authority, :contact_name, :contact_email, :contact_phone,
       :authorizer, :authorizer_title, :authorizer_email, :authorizer_phone, :effective_date].each do |attr|
       expect(blank_declaration).to respond_to attr
      end
    end
  end
end
