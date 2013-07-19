class FillInBlankSolution < ActiveRecord::Base
  belongs_to :question
  attr_accessible :content, :position, :_destroy

  acts_as_list scope: :question

  validates :content, presence: true
end
