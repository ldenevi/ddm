class Review < ActiveRecord::Base
  # Display information
  attr_accessible :frequency, :name,
                  :organization, :organization_id,
                  :responsible_party, :responsible_party_id,
                  :organization_template, :status

  belongs_to :organization
  belongs_to :responsible_party, :class_name => 'User'
  belongs_to :organization_template
  
  # Tracking
  attr_accessible :actual_completion_at, :actual_start_at,
                  :targeted_completion_at, :targeted_start_at,
                  :assigned_at, :deployed_at
  
  # Relationship
  attr_accessible :organization_template_id, :tasks_attributes
  has_many   :comments, :order => 'created_at DESC', :as => :commentable
  has_many   :tasks,    :order => 'sequence'
  accepts_nested_attributes_for :tasks, :allow_destroy => true
end
