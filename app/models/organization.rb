class Organization < ActiveRecord::Base
  
  # ECOTree hierarchy
  include GSP::UI::Javascript::EcoTree
  make_ecotree :class_name => 'Organization', :children => 'organizations'
  
  # Display information
  attr_accessible :full_name, :display_name, :governing_law, :owner
  belongs_to :owner, :class_name => 'User'
  belongs_to :governing_law, :class_name => 'User'  # Using User just as a placeholder; eventually there'd be a mangeble Law object
  has_many   :users
  has_many   :purchased_templates
  after_create :set_owner, :if => lambda { |o| o.owner_id.nil? }
  
  def name
    "#{full_name} (#{self.purchased_templates.size.to_s})"
  end
  
private
  
  def set_owner
    update_attribute(:owner_id, parent.owner_id) unless parent.nil?
  end
end
