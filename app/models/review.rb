class Review < ActiveRecord::Base
  attr_accessible :actual_completion_at, :assigned_at, :due_at,
                  :frequency, :name, :owner, :status,
                  :start_at, :deployed_at, :purchased_template,
                  :organization
  
  belongs_to :owner, :class_name => 'User'
  belongs_to :purchased_template
  belongs_to :organization
  has_many   :comments, :order => 'created_at DESC'
  has_many   :tasks, :order => 'sequence'
  
end
