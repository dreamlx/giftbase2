class Grade < ActiveRecord::Base
  has_many :stages
  has_many :units, through: :stages
  has_many :exams, through: :units
  has_many :answers, through: :exams
  has_many :pictures, as: :imageable, dependent: :destroy

  attr_accessible :description, :name
end
