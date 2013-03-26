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
end
