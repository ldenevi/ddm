require 'spec_helper'

describe GSP::Models::Tree::ActiveRecord do
  before(:all) do
    ActiveRecord::Schema.define do
      create_table :ar_models do |t|
        t.column :root_parent_id, :integer
        t.column :parent_id, :integer
        t.column :is_leaf, :boolean
        t.column :is_branch, :boolean
      end
    end
    class ARModel < ActiveRecord::Base
      include GSP::Models::Tree::ActiveRecord
    end
  end
  after(:all) do
    ActiveRecord::Schema.define do
      drop_table :ar_models
    end
  end
  let(:klass) { ARModel.create }

  it "should have required methods" do
    expect(klass.class).to respond_to :make_into_tree
    expect(klass.class.make_into_tree).to be_true
    expect(klass).to respond_to :child_nodes
    expect(klass).to respond_to :parent
    expect(klass).to respond_to :root_parent
    expect(klass).to respond_to :leaves
    expect(klass).to respond_to :set_root_parent
    expect(klass).to respond_to :set_tree_position
  end

  it "should make ActiveRecord model into a tree" do
    # root
    #  |
    #  +-- child1
    #  |
    #  +-- child2
    #        |
    #        +-- child3
    #        +-- child4
    #               |
    #               +-- child5
    root = ARModel.create
    child1 = ARModel.create :parent => root
    child2 = ARModel.create :parent => root
    child3 = ARModel.create :parent => child2
    child4 = ARModel.create :parent => child2
    child5 = ARModel.create :parent => child4
    expect(root.child_nodes.size).to eq 2
    expect(root.leaves.size).to eq 3
    expect(root.is_leaf?).to be_false
    expect(child1.is_leaf?).to be_true
    expect(child2.is_leaf?).to be_false
    expect(child2.is_branch?).to be_true
    expect(child3.is_leaf?).to be_true
    expect(child4.is_leaf?).to be_false
    expect(child4.is_branch?).to be_true
    expect(child5.is_leaf?).to be_true
    expect(child5.root_parent).to eq root
    expect(child4.root_parent).to eq root
    expect(child3.root_parent).to eq root
    expect(child2.root_parent).to eq root
    expect(child1.root_parent).to eq root
  end
end
