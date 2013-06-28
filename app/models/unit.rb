class Unit < ActiveRecord::Base
  has_many :question_groups, dependent: :destroy, order: 'position'
  has_many :question_line_items, through: :question_groups
  has_many :questions, through: :question_line_items
  has_many :exams, dependent: :destroy
  belongs_to :stage

  attr_accessible :description, :exam_minutes, :name, :stage_id

  validates :name, :exam_minutes, presence: true
  
  has_one :user_unit
  has_one :user, through: :user_unit
  
  scope :only_owner, lambda { |user| user.unit_ids.blank? ? where("#{Unit.table_name}.id is null") : where("#{Unit.table_name}.id IN (?)", user.unit_ids) }
  
  def belong_user(user)
    UserUnit.create(user_id: user.id, unit_id: self.id) 
  end
end
