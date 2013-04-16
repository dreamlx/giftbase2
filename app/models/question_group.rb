class QuestionGroup < ActiveRecord::Base
  belongs_to :unit
  has_many :question_line_items, dependent: :destroy, order: 'position'
  has_many :questions, through: :question_line_items

  acts_as_list scope: :unit

  attr_accessible :description, :name, :position

  def add_question(question, point = 1)
    QuestionLineItem.find_or_create_by_question_id_and_question_group_id(question.id, self.id) do |question_line_item|
      question_line_item.point = point
    end
  end

  def remove_question(question)
    QuestionLineItem.where(question_id: question.id, question_group_id: self.id).destroy_all
  end
end
