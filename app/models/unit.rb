class Unit < ActiveRecord::Base
  has_many :question_groups, dependent: :destroy, order: 'position'
  has_many :question_line_items, through: :question_groups
  has_many :questions, through: :question_line_items
  has_many :exams, dependent: :destroy
  belongs_to :stage

  amoeba do
    enable
  end

  attr_accessible :description, :exam_minutes, :name, :stage_id

  validates :name, :exam_minutes, presence: true
  
  has_one :user_unit
  has_one :user, through: :user_unit
  has_many :map_places, as: :placeable, dependent: :destroy
  
  acts_as_list :scope => :stage
  scope :only_owner, lambda { |user| user.unit_ids.blank? ? where("#{Unit.table_name}.id is null") : where("#{Unit.table_name}.id IN (?)", user.unit_ids) }
  
  def belong_user(user)
    UserUnit.create(user_id: user.id, unit_id: self.id) 
  end

  def unlock(user)
    user_unit = UserUnit.where(user_id: user.id, unit_id: self.id).first
    user_unit.unlock_unit
  end

  def unlock?(user)
    user_unit = UserUnit.where(user_id: user.id, unit_id: self.id).first
    if user_unit.state == "unlock"
      return true
    else
      return false
    end
  end

  def pre_question_line_item(position)
    if position == self.question_line_items.order("question_line_items.position").first
      self
    else
      self.question_line_items.where("question_line_items.position < ?", position).order("question_line_items.position desc").first
    end
  end

  def next_question_line_item(position)
    if position == self.question_line_items.order("question_line_items.position desc").first
      self
    else
      self.question_line_items.where("question_line_items.position > ?", position).order("question_line_items.position").first
    end
  end
end
