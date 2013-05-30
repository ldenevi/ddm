class Task < ActiveRecord::Base
  validate :reviewer, :presence => true
  validate :instructions, :presence => true
  validate :sequence, :presence => true
  validate :status, :presence => true
  validate :review, :presence => true
  
  # Display information
  attr_accessible :comments, 
                  :reviewer, :reviewer_id,
                  :completion_percentage, :instructions,
                  :name, :review, :sequence, :status
  belongs_to :reviewer, :class_name => 'User'
  belongs_to :review
  has_many   :comments, :as => :commentable
  
  # Tracking
  attr_accessible :actual_completion_at, :assigned_at, :expected_completion_at,
                  :start_at
  
  # Recurrence schedule
  serialize :schedule, Hash
  
  def assign_to(user_id)
    self.reviewer_id = (user_id.is_a?(User)) ? user_id.id : user_id
    self.assigned_at = Time.now
    self.save
  end
  
  def conform!
    update_attributes(:status => GSP::STATUS::TASK::CONFORMING, :actual_completion_at => Time.now)
  end
  
  def not_conform!
    update_attributes(:status => GSP::STATUS::TASK::NON_CONFORMING, :actual_completion_at => Time.now)
  end
  
  def reopen!
    update_attributes(:status => GSP::STATUS::TASK::INACTIVE, :actual_completion_at => nil)
  end
  
  def is_completed?
    !self.actual_completion_at.nil?
  end
end
