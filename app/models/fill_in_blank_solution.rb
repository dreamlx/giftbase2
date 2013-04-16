class FillInBlankSolution < ActiveRecord::Base
  belongs_to :question
  attr_accessible :content, :position, :_destroy

  validates :content, presence: true
end
