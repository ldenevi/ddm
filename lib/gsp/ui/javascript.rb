module GSP::UI::Javascript
  module EcoTree
    def to_ecotree_array
      ([self.to_ecotree_node(true)] + gather_children(self)[1..-1])
    end
    
protected
    def to_ecotree_node(is_parent = false)
      {:name => self.name, :id => self.id, :parent_id => (is_parent ? -1 : self.parent.id)}
    end
    
    def gather_children(org)
      array = [org.to_ecotree_node]
      org.organizations.each do |o|
        array += gather_children(o)
      end
      array
    end
  end
      
end

