class Cfsi::ValidationsBatch < ActiveRecord::Base
  before_create "self.status = 'Initialized'"

  belongs_to :organization
  belongs_to :user
  attr_accessible :status, :organization, :user
  validates :organization, :presence => true
  validates :user, :presence => true

  has_many :unidentified_cmrt_validations, :class_name => 'Cfsi::CmrtValidation', :conditions => "vendor_id IS NULL"
  attr_accessible :unidentified_cmrt_validations

  has_many :vendor_cmrt_validations, :class_name => 'Cfsi::CmrtValidation', :conditions => "vendor_id IS NOT NULL", :order => :created_at
  attr_accessible :vendor_cmrt_validations

  has_many :cmrt_validations
  attr_accessible :cmrt_validations

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
    cmrt_validations.map(&:cmrt).compact.map(&:minerals_vendor)  # TODO Figure out why the CmrtValidaiton#vendor does not load unless Cmrt#minerals_vendor is called. This line shouldn't be necessary
    vendor_cmrt_validations.group_by(&:vendor)
  end

  def latest_cmrt_validations
    unidentified_cmrt_validations + grouped_vendor_cmrt_validations.collect { |vendor, cmrt_validations| cmrt_validations.last }
  end
end
