class Cfsi::ValidationsBatch < ActiveRecord::Base
  before_create "self.status = 'Initialized'"

  belongs_to :organization
  belongs_to :user
  attr_accessible :status, :organization, :user

  has_many :unidentified_cmrts, :class_name => 'Cfsi::Cmrt', :conditions => "vendor_id IS NULL"
  attr_accessible :unidentified_cmrts

  has_many :vendor_cmrts, :class_name => 'Cfsi::Cmrt', :conditions => "vendor_id IS NOT NULL"
  attr_accessible :vendor_cmrts

  has_many :cmrt_validations

  # Analytics
  has_many :green_status_validations, :class_name => 'Cfsi::CmrtValidation', :conditions => { :status => 'Green'}
  has_many :validation_needed_validations, :class_name => 'Cfsi::CmrtValidation', :conditions => { :status => 'Validation needed'}
  has_many :high_risk_validations, :class_name => 'Cfsi::CmrtValidation', :conditions => { :status => 'High risk'}
  has_many :error_validations, :class_name => 'Cfsi::CmrtValidation', :conditions => { :status => 'File not readable'}

  def state
    status
  end

  def transition_to_processing
    update_attribute(:status, "Processing")
  end

  def transition_to_completed
    update_attribute(:status, "Completed")
  end
end
