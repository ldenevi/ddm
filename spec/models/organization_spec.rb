require 'spec_helper'

describe Organization do
  describe 'data validations' do
    it 'should prevent hazardous field values' do
      pending 'must have name, display_name, & owner'
    end
  end
  
  describe 'behavior' do
    it 'should be hierarchical' do
      pending 'check parent_id, root_parent_id, is_leaf, is_branch'
    end
    
    it 'should output ECOTree.js-readable JSON array' do
      pending '{:name => string, :id => integer, :parent_id => integer}'
    end
  end
end
