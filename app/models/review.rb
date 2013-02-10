class Review < ActiveRecord::Base
  # Display information
  attr_accessible :frequency, :name, :organization, :owner,
                  :purchased_template, :status
  belongs_to :organization
  belongs_to :owner, :class_name => 'User'
  belongs_to :purchased_template
  
  # Tracking
  attr_accessible :actual_completion_at, :assigned_at, :deployed_at,
                  :due_at, :start_at
  
  # Relationship
  has_many   :comments, :order => 'created_at DESC', :as => :commentable
  has_many   :tasks,    :order => 'sequence'
end
