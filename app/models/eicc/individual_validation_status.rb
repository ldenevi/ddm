class Eicc::IndividualValidationStatus < Eicc::ValidationStatus
  attr_accessible :declaration, :company_name
  
  belongs_to :parent, :class_name => "Eicc::ValidationStatus"
  belongs_to :declaration, :class_name => "Eicc::Declaration"
  
  # validates :uploaded_file_path, :filename, :is_spreadsheet_return_email_sent, :presence => true
end
