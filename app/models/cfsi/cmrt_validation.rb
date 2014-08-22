class Cfsi::CmrtValidation < ActiveRecord::Base
  before_create "self.status = 'Initialized'"

  has_one :spreadsheet,  :as => :attachable, :class_name => Spreadsheet
  belongs_to :cmrt
  belongs_to :validations_batch
  belongs_to :vendor
  attr_accessible :cmrt, :validations_batch, :email_sent_at, :issues, :sent_emails_count,
                  :status, :validation_attempt, :spreadsheet

  belongs_to :organization
  attr_accessible :organization
  validates :organization, :presence => true
  belongs_to :user
  attr_accessible :user
  validates :user, :presence => true

  attr_accessor :system_errors
  attr_accessor :backtrace

  has_many :previous_validations, :readonly => true, :class_name => "Cfsi::CmrtValidation", :finder_sql => Proc.new {
                                                                                                                %Q{
                                                                                                                  SELECT v.*
                                                                                                                  FROM cfsi_cmrt_validations v
                                                                                                                  WHERE v.validations_batch_id = #{validations_batch_id} AND v.vendor_id = #{vendor_id} AND v.id <> #{id}
                                                                                                                  ORDER BY v.created_at
                                                                                                                }
                                                                                                            }

  def self.generate(file_path, attrs = {})
    raise ArgumentError, ":user is nil" if attrs[:user].nil?
    attrs.merge!(:user => attrs[:user], :organization => (attrs[:organization] || attrs[:user].organization))
    obj = create attrs.merge({:spreadsheet => Spreadsheet.generate({:filename => File.basename(file_path), :data => File.read(file_path), :user => attrs[:user]})})
    obj.spreadsheet.save_to_filesystem!
    obj
  end

  def transition_to(new_state, args = {:message => nil})
    self.status = new_state
    self.issues = args[:message]
    save!
  end

  def transition_to_opened
    transition_to("Opening", :message => "Attempting to open CMRT spreadsheet")
    begin
      self.cmrt = Cfsi::Cmrt.generate(file_path, :organization => self.organization)
      self.cmrt.save!(:validate => false)
      update_attribute(:vendor_id, self.cmrt.minerals_vendor.id)
      self.validation_attempt = (self.previous_validations.last.nil?) ? 1 : self.previous_validations.last.validation_attempt.to_i + 1 unless validations_batch.nil?
      transition_to("Opened")
    rescue $!
      self.system_errors = $!.message
      self.backtrace = $!.backtrace
      transition_to_file_not_readable($!.message)
    end
  end

  def transition_to_file_not_readable(errors = '')
    transition_to("File not readable", :message => "Cannot read " + errors)
  end

  def transition_to_validated
    return false if state == "File not readable"
    transition_to("Validating", :message => "Analyzing CMRT spreadsheet")
    if cmrt.declaration.valid?
      transition_to("Green")
    else
      issues = cmrt.declaration.errors.full_messages.uniq
      status = issues.join("").downcase.match("high risk").nil? ? "Validation needed" : "High risk"
      transition_to(status, :message => issues.map { |m| "<li>#{m}</li>" }.join("\n"))
    end
  end

  def state
    status
  end

  def file_name
    spreadsheet ? spreadsheet.filename : ''
  end

  def file_extension
    spreadsheet ? File.extname(file_name) : ''
  end

  def file_path
    spreadsheet ? spreadsheet.storage_path : ''
  end

  def has_cmrt?
    !cmrt.nil?
  end

  def has_declaration?
    !(cmrt.nil? || cmrt.declaration.nil?)
  end
end
