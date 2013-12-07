class ChildParent < ActiveRecord::Base
  attr_accessible :child_id, :parent_id, :verify_parent
  belongs_to :parent, class_name:"User"
  belongs_to :child, class_name:"User"

  validates :parent_id, presence: true
  validates :child_id, presence: true

  validates_uniqueness_of :parent_id, scope: :child_id
end
