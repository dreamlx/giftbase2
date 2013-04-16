class BriefSolution < ActiveRecord::Base
  belongs_to :question, class_name: 'Question::Brief'

  validates :content, presence: true

  attr_accessible :content
end
