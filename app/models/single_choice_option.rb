class SingleChoiceOption < ActiveRecord::Base
  belongs_to :question, class_name: 'Question::SingleChoice'

  acts_as_list

  attr_accessible :content, :correct, :position, :sequence, :_destroy

  validates :content, presence: true

  default_value_for :correct, false
end
