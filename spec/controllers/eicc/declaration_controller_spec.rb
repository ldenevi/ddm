require 'spec_helper'

describe Eicc::DeclarationController do
  context "while using Internet Explorer 9 or below" do
    ZIP_FILEPATH = File.join(Rails.root, 'spec/controllers/eicc/zipped_declarations.zip')

    it "should not have any Eicc::ValidationStatus for testing" do
      expect(Eicc::ValidationStatus.count).to eq 0
    end

    let(:uploaded_file) do
     filepath = File.join(Rails.root, 'spec/controllers/eicc/zipped_declarations.zip')
     file     = File.open(filepath)
     uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(filepath), :content_type => 'application/vnd.ms-excel')
    end

    it "should accept and unpack zip file containing EICC/GeSI reports" do
      expect { post("upload_zip", :zip => uploaded_file) }.to change{Eicc::ValidationStatus.count}.from(0).to(18)

      # expect(response).to eq 200
    end

  end
end
