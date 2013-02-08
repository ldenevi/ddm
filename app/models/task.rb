class Task < ActiveRecord::Base
  attr_accessible :actual_completion_at, :assigned_at, :completion_percentage, :expected_completion_at, :instructions, :name, :review, :sequence, :status
  
  belongs_to :review
end
