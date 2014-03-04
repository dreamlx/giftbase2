class QuestionLevel < ActiveRecord::Base
  attr_accessible :name
  has_many :questions
end
