class Question2LineItem < ActiveRecord::Base
  belongs_to :question
  belongs_to :question_group
  has_many :answers
  
  acts_as_list scope: :question_group

  attr_accessible :point, :position, :question, :question_group
end
