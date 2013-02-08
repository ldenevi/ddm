class Organization < ActiveRecord::Base
  include GSP::UI::Javascript::EcoTree
  
  attr_accessible :display_name, :name, :owner, :parent, :region
  
  # Node data
  attr_accessible :is_branch, :is_leaf, :root_parent
  
  belongs_to :owner, :class_name => 'User'
  has_many   :organizations, :foreign_key => 'parent_id'
  belongs_to :parent, :class_name => 'Organization'
  belongs_to :root_parent, :class_name => 'Organization'
  has_many   :leaves, :class_name => 'Organization', :foreign_key => 'root_parent_id', :conditions => {:is_leaf => true, :is_branch => false}
  has_many   :users
  has_many   :purchased_templates
  
  after_create :set_root_parent
  after_create :set_owner, :if => lambda { |o| o.owner_id.nil? }
  after_create :set_tree_position
  
private
  def set_root_parent
    if parent.nil?
      update_attribute(:root_parent_id, self.id)
    else
      update_attribute(:root_parent_id, parent.root_parent_id)
    end
  end
  
  def set_owner
    update_attribute(:owner_id, parent.owner_id)
  end
  
  def set_tree_position
    # root
    if parent_id.nil?
      update_attributes(:is_leaf => false, :is_branch => false)
    #leaf
    elsif organizations.empty?
      update_attributes(:is_leaf => true, :is_branch => false)
      parent.update_attributes(:is_leaf => false, :is_branch => true)
    end
  end
  
end
