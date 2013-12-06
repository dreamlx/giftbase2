require 'spec_helper'

describe ParentsChildren do
  let(:parent){ FactroyGril.create(:user)}
  let(:children){ FactroyGril.create(:user)}
  let(:parent_children){ parent.parents_children.build(children_id: children.id)}

  subject{parent_children}

  it{should be_vaild}
end
