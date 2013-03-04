class Agency < ActiveRecord::Base

  # Display information
  attr_accessible :acronym, :name, :website
  
  has_many :gsp_templates
  has_many :organization_templates
end
