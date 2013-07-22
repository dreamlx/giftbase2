class MultipleChoiceOption < ActiveRecord::Base
  belongs_to :question, class_name: 'Question::MultipleChoice'

  scope :corrects, lambda { where(correct: true) }

  acts_as_list scope: :question

  attr_accessible :content, :correct, :position, :sequence, :_destroy

  validates :content, presence: true

  default_value_for :correct, false

  def alpha_position
    ('A'.ord + self.position - 1).chr
  end
end
