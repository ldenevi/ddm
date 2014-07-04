class Division < Organization
  belongs_to :root_parent, :class_name => 'Company'
  belongs_to :admin, :class_name => 'User', :foreign_key => 'owner_id'
  validate :users, :presence => true

  validate do |record|
    record.errors.add(:division, "limit exceeded (#{record.root_parent.division_limit})") if record.root_parent && record.root_parent.divisions.size >= record.root_parent.division_limit
  end
end
