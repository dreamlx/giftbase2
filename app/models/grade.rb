class Grade < ActiveRecord::Base
  has_many :stages
  has_many :pictures, as: :imageable, dependent: :destroy

  attr_accessible :description, :name
end
