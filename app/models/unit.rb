class Unit < ActiveRecord::Base
  has_many :question_groups, dependent: :destroy, order: 'position'
  has_many :questions, through: :question_groups

  attr_accessible :description, :exam_minutes, :name

  validates :name, :exam_minutes, presence: true
end
