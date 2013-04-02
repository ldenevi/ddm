class Task < ActiveRecord::Base
  validate :executor, :presence => true
  validate :instructions, :presence => true
  validate :sequence, :presence => true
  validate :status, :presence => true
  validate :review, :presence => true
  
  # Display information
  attr_accessible :comments, 
                  :executor, :executor_id,
                  :completion_percentage, :instructions,
                  :name, :review, :sequence, :status
  belongs_to :executor, :class_name => 'User'
  belongs_to :review
  has_many   :comments, :as => :commentable
  
  # Tracking
  attr_accessible :actual_completion_at, :assigned_at, :expected_completion_at,
                  :start_at
  
  def assign_to(user_id)
    self.executor_id = (user_id.is_a?(User)) ? user_id.id : user_id
    self.assigned_at = Time.now
    self.save
  end
  
  def complete!
    self.status = GSP::STATUS::COMPLETED
    self.actual_completion_at = Time.now
    self.save
  end
  
  def reopen!
    self.status = GSP::STATUS::PENDING
    self.actual_completion_at = nil
    self.save
  end
  
  def is_completed?
    !self.actual_completion_at.nil?
  end
end
