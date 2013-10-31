class Eicc::IndividualValidationStatus < Eicc::ValidationStatus
  attr_accessible :filename, :is_spreadsheet_return_email_sent, :message,
                  :representative_email, :status, :type, :uploaded_file_path, :user,
                  :declaration, :review, :company_name, :template_version
  
  belongs_to :parent, :class_name => "Eicc::BatchValidationStatus"
  belongs_to :declaration, :class_name => "Eicc::Declaration"
end
