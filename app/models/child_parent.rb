class ChildParent < ActiveRecord::Base
  attr_accessible :child_id, :parent_id, :verify_parent
  belongs_to :parent, class_name:"User"
  belongs_to :child, class_name:"User"

  validates :parent_id, presence: true
  validates :child_id, presence: true

  validates_uniqueness_of :parent_id, scope: :child_id

  after_save :parent_exams_to_child

  def parent_exams_to_child
  	if self.verify_parent
      child = User.find(self.child_id)
      parent = User.find(self.parent_id)
      child.grades << parent.grades
      child.stages << parent.stages
      child.units << parent.units
    end
  end
end
