class Template < ActiveRecord::Base
  attr_accessible :agency_display_name, :agency, :author, :description, :display_name, :frequency, :full_name, :objectives, :regulatory_review_name, :tasks
  
  # Relationships
  belongs_to :agency
  belongs_to :author
  
end
