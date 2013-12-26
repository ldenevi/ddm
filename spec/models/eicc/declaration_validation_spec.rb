require 'spec_helper'

EICC_XLS_PATH     = File.join(File.dirname(__FILE__), "declaration_spec_data")
VERSIONS = %w(2.00 2.01 2.02 2.03 2.03a)

describe Eicc::Declaration do

  # Empty
  context "during empty EICC/GeSI template submission" do
    VERSIONS.each do |version|
      let (:declaration) { Eicc::Declaration.generate File.join(EICC_XLS_PATH, version, "#{version}_-_empty.xls") }

      it "should not be valid" do
        declaration.should_not be_valid
      end

      it "should contain error messages" do
        declaration.should_not be_valid
        declaration.errors.full_messages.should_not be_empty

        ["Company name Validation Needed: Respondent has not provided a company name",
          "Declaration scope Validation Needed: Respondent has declared it is reporting at the product level but has not listed products on the Report's Product List",
          "Authorized company representative name Validation Needed: Respondent has not provided an Authorized Company Representative contact name",
          "Representative email Validation Needed: Respondent has not provided a representative e-mail",
          "Completion at Validation Needed: Respondent did not provide a date of completion",
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
          declaration.errors.full_messages.uniq.should include message
        end
      end

      it "should not contain any smelter" do
        declaration.smelter_list.should be_empty
      end

      it "should contain standard smelter names" do
        declaration.standard_smelter_names.should_not be_empty
      end
    end
  end

  # Valid 1
  context "during valid EICC/GeSI template submission #1" do
    VERSIONS.each do |version|
      let (:declaration) { Eicc::Declaration.generate File.join(EICC_XLS_PATH, version, "#{version}_-_valid_1.xls") }

      it "should be valid" do
        declaration.should be_valid
      end

      it "should not contain error messages" do
        declaration.should be_valid
        declaration.errors.full_messages.should be_empty
      end

      it "should contain smelters" do
        declaration.smelter_list.should_not be_empty
      end

      it "should contain standard smelter names" do
        declaration.standard_smelter_names.should_not be_empty
      end
    end
  end

  # Valid 2
  context "during valid EICC/GeSI template submission #2" do
    VERSIONS.each do |version|
      let (:declaration) { Eicc::Declaration.generate File.join(EICC_XLS_PATH, version, "#{version}_-_valid_2.xls") }

      it "should be valid" do
        declaration.should be_valid
      end

      it "should not contain error messages" do
        declaration.should be_valid
        declaration.errors.full_messages.should be_empty
      end

      it "should contain smelters" do
        declaration.smelter_list.should_not be_empty
      end

      it "should contain standard smelter names" do
        declaration.standard_smelter_names.should_not be_empty
      end
    end
  end


end
