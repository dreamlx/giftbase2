class ParentsChildren < ActiveRecord::Base
  attr_accessible :children_id, :parent_id
  belongs_to :parents, class_name:"User"
  belongs_to :children, class_name:"User"

  validates :parent_id, presence: true
  validates :child_id, presence: true
end
