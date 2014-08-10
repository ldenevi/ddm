class Agency < Organization
  def url
    properties[:url]
  end

  def url=(value)
    properties.merge({:url => value})
  end

  def self.find_by_acronym(val)
    where("name LIKE '%#{val}'").first
  end

  def self.in_house
    where("name LIKE 'In-House'").first
  end

  def acronym
    name.split(/W/).collect { |w| w[0] }.join('')
  end


=begin
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
=end
end