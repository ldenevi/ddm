require 'spec_helper'

EICC_XLS_FILEPATH = File.join(File.dirname(__FILE__), "declaration_spec_data", "eicc.xls")

describe Eicc::Declaration do
  context "(in general)" do
    let (:declaration) { Eicc::Declaration.generate EICC_XLS_FILEPATH }

    it "should contain required data" do
      declaration.should_not be_valid

      [:address, :authorized_company_representative_name, :company_name,
       :company_unique_identifier, :completion_at, :declaration_scope, :description_of_scope,
       :language, :representative_email, :representative_phone, :representative_title,
       :template_version, :updated_at, :validation_status].each do |attr|
       declaration.should respond_to attr
      end

      declaration.should respond_to :mineral_questions
      declaration.should respond_to :company_level_questions
      declaration.should respond_to :smelter_list
      declaration.should respond_to :standard_smelter_names
    end

    it "should respond to .generate" do
      Eicc::Declaration.generate(EICC_XLS_FILEPATH).class.should eq(Eicc::Declaration)
    end

    it "should convert Excel into CSV" do
      declaration.should respond_to :uploaded_excel
      declaration.should respond_to :csv_worksheets
    end
  end
end
