class Cfsi::CmrtValidation < ActiveRecord::Base
  belongs_to :cmrt
  belongs_to :validations_batch
  belongs_to :vendor
  attr_accessible :cmrt, :validations_batch, :email_sent_at, :issues, :sent_emails_count,
                  :status, :validation_attempt

  def self.generate(file_path)
    obj = new :status => "Opening",
               :issues => "Attempting to open spreadsheet"
    obj.cmrt = Cfsi::Cmrt.generate(file_path)
    obj
  end
end
