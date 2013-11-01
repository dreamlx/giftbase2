class Question::MultipleChoice < Question
  has_many :multiple_choice_options, order: :position, foreign_key: 'question_id', dependent: :destroy
  
  accepts_nested_attributes_for :multiple_choice_options, :reject_if => proc { |attributes| attributes[:content].blank? }, allow_destroy: true

  def self.instanceable?
    true
  end
  
  def can_auto_review?
    true
  end

  def build_relative
    super

    if new_record? && multiple_choice_options.blank?
      4.times { multiple_choice_options.build }
    end
    self
  end

  def auto_review(answer)
    if multiple_choice_options.corrects.map(&:id).sort == answer.option_ids.sort
      answer.point = answer.max_point
    else
      answer.point = 0
    end
    answer.save
    
    answer.mark_as_reviewed!
  end

  private

  def mass_assignment_authorizer(role = :default)
    super + [:multiple_choice_options_attributes]
  end
end
