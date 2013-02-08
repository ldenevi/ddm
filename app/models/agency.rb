class Agency < ActiveRecord::Base
  attr_accessible :acronym, :name, :website
  
  has_many :templates
end
