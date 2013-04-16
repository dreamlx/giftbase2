class Question::MultipleChoice < Question
  has_many :multiple_choice_options, order: :position, foreign_key: 'question_id', dependent: :destroy

  accepts_nested_attributes_for :multiple_choice_options, :reject_if => proc { |attributes| attributes[:content].blank? }, allow_destroy: true

  def self.instanceable?
    true
  end

  def build_relative
    super

    if new_record? && multiple_choice_options.blank?
      4.times { multiple_choice_options.build }
    end
    self
  end

  private

  def mass_assignment_authorizer(role = :default)
    super + [:multiple_choice_options_attributes]
  end
end
