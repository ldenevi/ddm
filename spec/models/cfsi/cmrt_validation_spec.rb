require 'spec_helper'

describe Cfsi::CmrtValidation do
  context "(in general)" do
    let(:blank_validation) { Cfsi::CmrtValidation.new }
    it "should have required attributes" do
      [:cmrt, :email_sent_at, :issues, :sent_emails_count, :status, :validation_attempt,
       :validations_batch, :vendor].each do |attr|
       expect(blank_validation).to respond_to attr
      end
    end

    let(:validation_issues) { Cfsi::CmrtValidation.generate File.join(File.dirname(__FILE__), 'sample_cmrts', '2.03a', '2.03a_-_empty.xls') }
    it "should generate a validation based on given Spreadsheet" do
      expect(validation_issues).not_to be_nil
    end

    pending "email CMRT issues to vendor"
    pending "discover the CMRT's MineralsVendor"
  end
end
