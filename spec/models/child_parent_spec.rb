require 'spec_helper'

describe ChildParent do
  
  before do
    @parent = User.first
    @child = User.last
    @parent_childs = @parent.child_parents.create(child_id: @child.id)
  	@child_parents = @child.child_parents.create(parent_id: @parent.id)
  end

  describe "parent should have children" do
  	subject{@parent}
  	its(:children){should include(@child)}
  end

  describe "child should have parents" do
  	subject{@child}
    its(:parents){should include(@parent)}
  end

  describe "when parent_id is not present" do
    before{@parent_childs.parent_id = nil}
    it{should_not be_valid}
  end

  describe "when child_id is not present" do
  	before{@parent_childs.child_id = nil}
  	it{should_not be_valid}
  end

end
