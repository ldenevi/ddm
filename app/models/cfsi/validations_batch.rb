class Cfsi::ValidationsBatch < ActiveRecord::Base
  before_create "self.status = 'Initialized'"

  belongs_to :organization
  belongs_to :user
  attr_accessible :status, :organization, :user
  validates :organization, :presence => true
  validates :user, :presence => true

  has_many :unidentified_cmrt_validations, :class_name => 'Cfsi::CmrtValidation', :conditions => "vendor_id IS NULL"
  attr_accessible :unidentified_cmrt_validations

  has_many :vendor_cmrt_validations, :class_name => 'Cfsi::CmrtValidation', :conditions => "vendor_id IS NOT NULL"
  attr_accessible :vendor_cmrt_validations

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

  def grouped_vendor_cmrt_validations
    vendor_cmrt_validations.group_by(&:vendor)
  end
end
