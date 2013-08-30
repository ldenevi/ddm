require 'spec_helper'

EICC_XLS_FILEPATH = File.join(File.dirname(__FILE__), "declaration_spec_data", "eicc.xls")

describe Eicc::Declaration do
  context "(in general)" do
    let (:declaration) { Eicc::Declaration.new }
    
    it "should contain required data" do
      declaration.should_not be_valid
    end
    
    it "should respond to .generate" do
      Eicc::Declaration.generate(EICC_XLS_FILEPATH).class.should eq(Eicc::Declaration)
    end
    
    it "should convert Excel into CSV" do
      declaration.should respond_to :uploaded_excel
      declaration.should respond_to :convert_to_csv
      declaration.should respond_to :csv_worksheets
    end
  end
  
  context "during invalid Excel file submission" do
    let (:declaration) { Eicc::Declaration.new }
    it "should fail on save" do
      declaration.should be_invalid
      declaration.save.should be_false
    end
  end
  
  context "during valid Excel file submission" do
    let (:declaration) do
      Eicc::Declaration.new :uploaded_excel => BinaryFile.generate(:filename => 'eicc.xls', :data => File.read(EICC_XLS_FILEPATH))
    end
    
    it "should convert Excel into multiple CSV files per worksheet" do
      declaration.convert_to_csv.should be_true
      declaration.csv_worksheets.size.should_not eq(0)
    end
    
    it "should create CSV objects containing stripped data for necessary worksheets" do
      declaration.convert_to_csv.should be_true
      declaration.should respond_to(:strip_worksheets)
      declaration.strip_worksheets.should be_true
      declaration.mineral_questions.size.should_not eq(0)
    end
  end
  
  context "during EICC data integrity inspection" do
    it "should not save 'red flagged' in checker" do
      pending "Use EICC spreadsheet 'checker' and other built-in data checks"
    end
  end
  
end
