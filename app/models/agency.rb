class Agency < ActiveRecord::Base

  # Display information
  attr_accessible :acronym, :name, :website
  
  has_many :templates
end
