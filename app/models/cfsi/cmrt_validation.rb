class Cfsi::CmrtValidation < ActiveRecord::Base
  before_create "self.status = 'Initialized'"

  has_one :spreadsheet,  :as => :attachable, :class_name => Spreadsheet
  belongs_to :cmrt
  belongs_to :validations_batch
  belongs_to :vendor
  attr_accessible :cmrt, :validations_batch, :email_sent_at, :issues, :sent_emails_count,
                  :status, :validation_attempt, :spreadsheet

  def self.generate(file_path, attrs = {})
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
      self.cmrt = Cfsi::Cmrt.generate(file_path)
      self.cmrt.save!(:validate => false)
      transition_to("Opened")
    rescue
      transition_to_file_not_readable
    end
  end

  def transition_to_file_not_readable
    transition_to("File not readable", :message => "Cannot read ")
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
    !self.cmrt.nil?
  end

  def has_declaration?
    !(self.cmrt.nil? || self.cmrt.declaration.nil?)
  end
end
