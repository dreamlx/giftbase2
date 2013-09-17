class Grade < ActiveRecord::Base
  has_many :stages, order: 'stages.position'
  has_many :units, through: :stages, order: "units.name"
  has_many :exams, through: :units
  has_many :answers, through: :exams
  has_many :pictures, as: :imageable, dependent: :destroy

  attr_accessible :description, :name
end
