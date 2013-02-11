class Review < ActiveRecord::Base
  # Display information
  attr_accessible :frequency, :name,
                  :organization, :organization_id,
                  :owner, :owner_id,
                  :purchased_template, :status

  belongs_to :organization
  belongs_to :owner, :class_name => 'User'
  belongs_to :purchased_template
  
  # Tracking
  attr_accessible :actual_completion_at, :assigned_at, :deployed_at,
                  :due_at, :start_at
  
  # Relationship
  attr_accessible :purchased_template_id, :tasks_attributes
  has_many   :comments, :order => 'created_at DESC', :as => :commentable
  has_many   :tasks,    :order => 'sequence'
  accepts_nested_attributes_for :tasks, :allow_destroy => true
end
