class Agency < Organization
  def url
    properties[:url]
  end

  def url=(value)
    properties.merge({:url => value})
  end

  def self.in_house
    where("name LIKE 'In-House'").first
  end

  def acronym
    properties[:acronym]
  end
  
  def acronym=(value)
    properties.merge({:acronym => value})
  end

  def self.find_by_acronym(val)
    where("properties LIKE '%acronym: #{val}%'").first
  end
end
