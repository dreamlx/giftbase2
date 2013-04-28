class Unit < ActiveRecord::Base
  has_many :question_groups, dependent: :destroy, order: 'position'
  has_many :questions, through: :question_groups

  attr_accessible :description, :exam_minutes, :name

  validates :name, :exam_minutes, presence: true
  
  has_one :user_unit
  has_one :user, through: :user_unit
  
  scope :only_owner, lambda { |user| user.unit_ids.blank? ? where(" id is null") : where('id IN (?)', user.unit_ids) }
  
  def belong_user(user)
    UserUnit.create(user_id: user.id, unit_id: self.id) 
  end
end
