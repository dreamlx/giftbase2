class Question::Brief < Question
  has_one :brief_solution, foreign_key: 'question_id', dependent: :destroy

  accepts_nested_attributes_for :brief_solution

  def self.instanceable?
    true
  end

  def build_relative
    super

    if new_record? && brief_solution.blank?
      build_brief_solution
    end
    self
  end

  private

  def mass_assignment_authorizer(role = :default)
    super + [:brief_solution_attributes]
  end
end
