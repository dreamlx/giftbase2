class ChildParent < ActiveRecord::Base
  attr_accessible :child_id, :parent_id
  belongs_to :parent, class_name:"User"
  belongs_to :child, class_name:"User"

  validates :parent_id, presence: true
  validates :child_id, presence: true
end
