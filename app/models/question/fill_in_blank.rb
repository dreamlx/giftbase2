class Question::FillInBlank < Question
  has_many :fill_in_blank_solutions, order: :position, foreign_key: 'question_id', dependent: :destroy

  accepts_nested_attributes_for :fill_in_blank_solutions, :reject_if => proc { |attributes| attributes[:content].blank? }, allow_destroy: true

  def self.instanceable?
    true
  end

  def build_relative
    super

    if new_record? && fill_in_blank_solutions.blank?
      fill_in_blank_solutions.build
    end
    self
  end

  private

  def mass_assignment_authorizer(role = :default)
    super + [:fill_in_blank_solutions_attributes]
  end
end
