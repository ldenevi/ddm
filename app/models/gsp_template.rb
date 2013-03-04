class GspTemplate < ActiveRecord::Base
  # Display information
  attr_accessible :price, :agency, :agency_id, :agency_display_name, :description,
                  :display_name, :frequency, :full_name, :objectives,
                  :regulatory_review_name, :tasks
  belongs_to :agency
  
  # Tracking
  attr_accessible :author
  belongs_to :author
  
  # STI
  attr_accessible :parent
  belongs_to :parent, :class_name => 'GspTemplate'
end
