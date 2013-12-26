require 'spec_helper'

describe Eicc::ValidationStatus do

  context "(in general)" do
    let(:status) { Eicc::ValidationStatus.new }

    it "should respond to required fields" do
      [:company_name, :created_at, :filename, :is_spreadsheet_return_email_sent, :message, :representative_email,
       :status, :template_version, :type, :updated_at, :uploaded_file_path, :user].each do |attr|
       expect(status).to respond_to(attr)
      end
    end
  end

end
