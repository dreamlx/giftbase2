class Question::Matching < Question
  has_many :matching_solutions, foreign_key: 'question_id', dependent: :destroy

  accepts_nested_attributes_for :matching_solutions, :reject_if => proc { |attributes| attributes[:source].blank? && attributes[:target].blank? }, allow_destroy: true

  def self.instanceable?
    true
  end

  def build_relative
    super

    if new_record? && matching_solutions.blank?
      4.times { matching_solutions.build }
    end
    self
  end

  private

  def mass_assignment_authorizer(role = :default)
    super + [:matching_solutions_attributes]
  end
end
