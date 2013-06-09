class Grade < ActiveRecord::Base
  has_many :stages

  attr_accessible :description, :name
end
