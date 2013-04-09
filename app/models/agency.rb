class Agency < ActiveRecord::Base

  # Display information
  attr_accessible :acronym, :name, :website
  
  has_many :gsp_templates
  has_many :organization_templates
  
  def logo_url
    "/images/agencies/%s.png" % ((acronym) ? acronym.downcase : 'in_house')
  end
  
  def logo_image_tag
    ("<img src=\"%s\" />" % logo_url).html_safe
  end
  
  def self.in_house
    where(:name => 'In-House').limit(1).first
  end
end
