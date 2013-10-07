class Eicc::ValidationStatus < ActiveRecord::Base
  attr_accessible :filename, :is_spreadsheet_return_email_sent, :message,
                  :representative_email, :status, :type, :uploaded_file_path, :user,
                  :declaration, :review

  validates :status, :presence => true
  
  has_many :individual_validation_statuses, :foreign_key => "parent_id", :order => "created_at DESC"
  has_many :completed,  :class_name => "Eicc::IndividualValidationStatus", :conditions => ["status <> '?'", "Validating"]
  has_many :validating, :class_name => "Eicc::IndividualValidationStatus", :conditions => { :status => "Validating" }
  
  has_many :accepted_individual_validation_statuses,    :class_name => "Eicc::IndividualValidationStatus", :conditions => { :status => "Green" }, :foreign_key => "parent_id"
  has_many :high_risk_individual_validation_statuses,   :class_name => "Eicc::IndividualValidationStatus", :conditions => { :status => "High Risk" }, :foreign_key => "parent_id"
  has_many :invalid_individual_validation_statuses,     :class_name => "Eicc::IndividualValidationStatus", :conditions => { :status => "Invalid" }, :foreign_key => "parent_id"
  has_many :individual_validation_statuses_with_errors, :class_name => "Eicc::IndividualValidationStatus", :conditions => { :status => "Error" }, :foreign_key => "parent_id"
  
  belongs_to :user
  belongs_to :declaration, :class_name => "Eicc::Declaration"
  belongs_to :review
  
  def uploaded_at
    created_at
  end
  
  def generate_review
    review = Review.new :responsible_party => self.user, :name => "EICC Declaration - #{uploaded_at.to_formatted_s(:long)}",
                          :organization => self.user.organization, :status => GSP::STATUS::ACTIVE,
                          :assigned_at => Time.now, :deployed_at => Time.now,
                          :targeted_completion_at => Time.now.end_of_year,
                          :targeted_start_at => Time.now

    self.individual_validation_statuses.each_with_index do |ivs, index|
      task = Task.new(:name => ivs.filename, :instructions => ivs.message,
                        :sequence => (index + 1),
                        :status => GSP::STATUS::ACTIVE, :reviewer => self.user,
                        :assigned_at => Time.now,
                        :start_at => Time.now,
                        :expected_completion_at => Time.now.end_of_year)
      comment = Comment.new :title => ivs.filename, :body => "", :author => user
      comment.attachments << BinaryFile.generate(:filename => ivs.filename, :data => File.read(ivs.uploaded_file_path))
      task.comments << comment
      review.tasks << task
    end
    review
  end
end