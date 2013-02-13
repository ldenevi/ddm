module GSP::UI::Javascript
  module EcoTree
    def EcoTree.included(obj)
      obj.send(:extend,  ClassMethods)
      obj.send(:include, InstanceMethods)
    end
  
    module ClassMethods
      def make_ecotree(config = {:class_name => 'NilClass', :children => :organizations})
        self.class_variable_set(:@@ecotree_children, config[:children])
        
        attr_accessible :name, :is_branch, :is_leaf, :root_parent, :parent
        
        has_many   config[:children], :foreign_key => 'parent_id'
        belongs_to :parent, :class_name => config[:class_name]
        belongs_to :root_parent, :class_name => config[:class_name]
        has_many   :leaves, :class_name => config[:class_name], :foreign_key => 'root_parent_id', :conditions => {:is_leaf => true, :is_branch => false}
        
        after_create :set_root_parent
        after_create :set_tree_position
      end
    end
    
    module InstanceMethods
      def children
        self.send(self.class.class_variable_get(:@@ecotree_children))
      end
      
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
        #leaf
        elsif children.empty?
          update_attributes(:is_leaf => true, :is_branch => false)
          parent.update_attributes(:is_leaf => false, :is_branch => true)
        end
      end
      
      def to_ecotree_array
        ([self.to_ecotree_node(true)] + gather_children(self)[1..-1])
      end
    protected
      def to_ecotree_node(is_parent = false)
        is_parent = true if self.id == self.root_parent_id
        {:name => self.name, :id => self.id, :parent_id => (is_parent ? -1 : self.parent.id)}
      end
      
      def gather_children(obj)
        array = [obj.to_ecotree_node]
        obj.children.each do |o|
          array += gather_children(o)
        end
        array
      end
    end
  
  end
end

