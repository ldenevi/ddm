class Company < Organization
  has_one :superadmin, :class_name => 'SuperAdmin'
  attr_accessible :superadmin
  validates :superadmin, :presence => true

  has_many :divisions, :class_name => 'Division', :foreign_key => 'root_parent_id'

  def division_limit
    properties[:division_limit].to_i
  end

  def division_limit=(value)
    properties[:division_limit] = value.to_i
  end
end
