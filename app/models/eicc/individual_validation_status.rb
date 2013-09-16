class Eicc::IndividualValidationStatus < Eicc::ValidationStatus
  belongs_to :parent, :class_name => "Eicc::ValidationStatus"
  
  # validates :uploaded_file_path, :filename, :is_spreadsheet_return_email_sent, :presence => true
end
