class Eicc::ValidationStatus < ActiveRecord::Base
  attr_accessible :filename, :is_spreadsheet_return_email_sent, :message,
                  :representative_email, :status, :type, :uploaded_file_path, :user

  validates :status, :presence => true
  
  has_many :individual_validation_statuses, :foreign_key => "parent_id", :order => "created_at DESC"
  has_many :completed,  :class_name => "Eicc::IndividualValidationStatus", :conditions => ["status <> '?'", "Validating"]
  has_many :validating, :class_name => "Eicc::IndividualValidationStatus", :conditions => { :status => "Validating" }
  
  has_many :accepted_individual_validation_statuses,    :class_name => "Eicc::IndividualValidationStatus", :conditions => { :status => "Green" }, :foreign_key => "parent_id"
  has_many :high_risk_individual_validation_statuses,   :class_name => "Eicc::IndividualValidationStatus", :conditions => { :status => "High Risk" }, :foreign_key => "parent_id"
  has_many :invalid_individual_validation_statuses,     :class_name => "Eicc::IndividualValidationStatus", :conditions => { :status => "Invalid" }, :foreign_key => "parent_id"
  has_many :individual_validation_statuses_with_errors, :class_name => "Eicc::IndividualValidationStatus", :conditions => { :status => "Error" }, :foreign_key => "parent_id"
  
  belongs_to :user
  
  def uploaded_at
    created_at
  end
end
