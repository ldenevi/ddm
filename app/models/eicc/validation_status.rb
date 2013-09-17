class Eicc::ValidationStatus < ActiveRecord::Base
  attr_accessible :filename, :is_spreadsheet_return_email_sent, :message,
                  :representative_email, :status, :type, :uploaded_file_path, :user

  validates :status, :presence => true
  
  has_many :individual_validation_statuses, :foreign_key => "parent_id", :order => "created_at DESC"
  has_many :completed,  :class_name => "Eicc::IndividualValidationStatus", :conditions => ["status <> '?'", "Validating"]
  has_many :validating, :class_name => "Eicc::IndividualValidationStatus", :conditions => { :status => "Validating" }
  belongs_to :user
  
  def uploaded_at
    created_at
  end
end
