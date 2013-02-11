class Task < ActiveRecord::Base
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
end
