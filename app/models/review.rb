class Review < ActiveRecord::Base
  attr_accessible :actual_completion_at, :assigned_at, :due_at, :frequency, :name, :owner, :status
  
  belongs_to :owner
  has_many   :comments, :order => 'created_at DESC'
  has_many   :tasks, :order => 'sequence'
  
end
