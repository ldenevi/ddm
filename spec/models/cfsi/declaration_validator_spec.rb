require 'spec_helper'

CFSI_CSV_WORKSHEETS_PATH = File.join(File.dirname(__FILE__), "sample_cmrts", "csv_worksheets")
DECLARATION_VERSIONS = %w(2.00 2.01 2.02 2.03 2.03a).map(&:to_s)
DECLARATION_STATES   = %w(empty valid_1 valid_2)

describe Cfsi::DeclarationValidator do

  DECLARATION_VERSIONS.each do |version|
    DECLARATION_STATES.each do |state|
      # puts Dir.glob(File.join(CFSI_CSV_WORKSHEETS_PATH, version, "*#{state}.csv.*"))
      let("#{state}_#{version.gsub('.', '_')}_declaration".to_sym) { Cfsi::Declaration.generate_from_csv_file_paths Dir.glob(File.join(CFSI_CSV_WORKSHEETS_PATH, version, "*#{state}.csv.*")) }
    end
  end

  # Empty
  context "during empty CFSI template submission" do
    DECLARATION_VERSIONS.each do |version|
      it "should not be valid" do
        eval("empty_#{version.gsub('.', '_')}_declaration").should_not be_valid
      end

      it "should contain error messages" do
        eval("empty_#{version.gsub('.', '_')}_declaration").should_not be_valid
        eval("empty_#{version.gsub('.', '_')}_declaration").errors.full_messages.should_not be_empty

        ["Validation Needed: Respondent has not provided a company name",
          "Validation Needed: Respondent has declared it is reporting at the product level but has not listed products on the Report's Product List",
          "Validation Needed: Respondent has not provided an Authorized Company Representative contact name",
          "Validation Needed: Respondent has not provided a representative e-mail",
          "Validation Needed: Respondent did not provide a date of completion",
          "Minerals Invalid Data: Respondent did not provide input for TANTALUM in Question 1",
          "Minerals Invalid Data: Respondent did not provide input for TIN in Question 1",
          "Minerals Invalid Data: Respondent did not provide input for GOLD in Question 1",
          "Minerals Invalid Data: Respondent did not provide input for TUNGSTEN in Question 1",
          "Company level Invalid Data: Respondent did not provide input for Question A",
          "Company level Invalid Data: Respondent did not provide input for Question B",
          "Company level Invalid Data: Respondent did not provide input for Question C",
          "Company level Invalid Data: Respondent did not provide input for Question D",
          "Company level Invalid Data: Respondent did not provide input for Question E",
          "Company level Invalid Data: Respondent did not provide input for Question F",
          "Company level Invalid Data: Respondent did not provide input for Question G",
          "Company level Invalid Data: Respondent did not provide input for Question H",
          "Company level Invalid Data: Respondent did not provide input for Question I",
          "Company level Invalid Data: Respondent did not provide input for Question J"].each do |message|
          eval("empty_#{version.gsub('.', '_')}_declaration").errors.full_messages.uniq.should include message
        end
      end

      it "should not contain any smelter" do
        eval("empty_#{version.gsub('.', '_')}_declaration").mineral_smelters.should be_empty
      end

      it "should contain standard smelter names" do
        eval("empty_#{version.gsub('.', '_')}_declaration").standard_smelter_names.should_not be_empty
      end

    end
  end

  # Valid 1
  context "during valid CFSI template submission #1" do
    DECLARATION_VERSIONS.each do |version|
      it "should be valid" do
        eval("valid_1_#{version.gsub('.', '_')}_declaration").should be_valid
      end

      it "should not contain error messages" do
        eval("valid_1_#{version.gsub('.', '_')}_declaration").should be_valid
        eval("valid_1_#{version.gsub('.', '_')}_declaration").errors.full_messages.should be_empty
      end

      it "should contain smelters" do
        eval("valid_1_#{version.gsub('.', '_')}_declaration").mineral_smelters.should_not be_empty
      end

      it "should contain standard smelter names" do
        eval("valid_1_#{version.gsub('.', '_')}_declaration").standard_smelter_names.should_not be_empty
      end
    end
  end

  # Valid 2
  context "during valid CFSI template submission #2" do
    DECLARATION_VERSIONS.each do |version|
      it "should be valid" do
        eval("valid_2_#{version.gsub('.', '_')}_declaration").should be_valid
      end

      it "should not contain error messages" do
        eval("valid_2_#{version.gsub('.', '_')}_declaration").should be_valid
        eval("valid_2_#{version.gsub('.', '_')}_declaration").errors.full_messages.should be_empty
      end

      it "should contain smelters" do
        eval("valid_2_#{version.gsub('.', '_')}_declaration").mineral_smelters.should_not be_empty
      end

      it "should contain standard smelter names" do
        eval("valid_2_#{version.gsub('.', '_')}_declaration").standard_smelter_names.should_not be_empty
      end
    end
  end

=begin
  context "during invalid CFSI version 2.02 w/column shift submission" do
    let (:declaration) { Cfsi::Declaration.generate File.join(CFSI_XLS_PATH, '2.02', "2.02_-_invalid_column_shift.xls") }

    it "should not be valid" do
      declaration.should_not be_valid
      declaration.errors.full_messages.uniq.should include "Company level Validation Needed: Respondent reported its verification process includes corrective action management to Question I but it did not provide a description of the corrective actions in the comments box"
    end

    it "should only have Gold and Tin in smelter list's Metal field" do
      declaration.smelter_list.should_not be_empty
      declaration.smelter_list.map(&:metal).uniq.sort.should eq ['Gold', 'Tin']
    end
  end
=end

end
