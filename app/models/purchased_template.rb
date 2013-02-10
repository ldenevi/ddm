class PurchasedTemplate < ActiveRecord::Base
  # Display information
  attr_accessible :agency, :agency_display_name,
                  :description, :display_name, :frequency, :full_name,
                  :objectives, :organization, :regulatory_review_name,
                  :template
  belongs_to :agency
  belongs_to :organization

  # Revisions
  attr_accessible :revision, :is_latest_revision
  
  # Tasks
  attr_accessible :tasks
  serialize       :tasks, JSON
  
  # Search filters
  attr_accessible :is_archived
  
  # Tracking
  attr_accessible :approved_by, :approved_at, :modified_by, :purchased_by,
                  :shared_by, :shared_at
  belongs_to :approved_by,  :class_name => 'User'
  belongs_to :modified_by,  :class_name => 'User'
  belongs_to :purchased_by, :class_name => 'User'
  belongs_to :shared_by,    :class_name => 'User'
  
  # ECOTree hierarchy
  extend  GSP::UI::Javascript::EcoTree::ClassMethods
  include GSP::UI::Javascript::EcoTree::InstanceMethods
  make_ecotree :class_name => 'PurchasedTemplate', :children => 'purchased_templates'
    
  
  def deploy_reviews
    
  end
end
