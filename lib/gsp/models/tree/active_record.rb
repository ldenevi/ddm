module GSP::Models::Tree::ActiveRecord
  def self.included(obj)
    obj.send(:extend,  ClassMethods)
    obj.send(:include, InstanceMethods)
    obj.send(:make_into_tree)
  end

  module ClassMethods
    def make_into_tree(config = {:class_name => self.to_s, :children_name => :child_nodes})
      self.class_variable_set(:@@tree_child_nodes_name, config[:children_name])
      attr_accessible :is_branch, :is_leaf, :root_parent, :parent
      has_many   config[:children_name], :class_name => config[:class_name], :foreign_key => 'parent_id'
      belongs_to :parent, :class_name => config[:class_name]
      belongs_to :root_parent, :class_name => config[:class_name]
      has_many   :leaves, :class_name => config[:class_name], :foreign_key => 'root_parent_id', :conditions => {:is_leaf => true, :is_branch => false}
      after_create :set_root_parent
      after_create :set_tree_position
      true
    end
  end

  module InstanceMethods
    def set_root_parent
      if parent.nil?
        update_attribute(:root_parent_id, self.id)
      else
        update_attribute(:root_parent_id, parent.root_parent_id)
      end
    end

    def set_tree_position
      # root
      if parent_id.nil?
        update_attributes(:is_leaf => false, :is_branch => false)
      # leaf
      elsif self.send(self.class.class_variable_get(:@@tree_child_nodes_name))
        update_attributes(:is_leaf => true, :is_branch => false)
        parent.update_attributes(:is_leaf => false, :is_branch => true)
      end
    end
  end
end
