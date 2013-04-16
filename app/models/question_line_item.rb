class QuestionLineItem < ActiveRecord::Base
  belongs_to :question
  belongs_to :question_group
  
  acts_as_list scope: :question_group

  attr_accessible :point, :position, :question, :question_group
end
