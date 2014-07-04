class Company < Organization
  has_one :superadmin, :class_name => 'SuperAdmin'
  validates :superadmin, :presence => true

  def division_limit
    properties[:division_limit].to_i
  end
end
