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

  def auto_review(answer)
    if compare_answer_matches(answer)
      answer.point = answer.max_point
    else
      answer.point = 0
    end
    answer.save
    
    answer.mark_as_reviewed!
  end

  private

  def compare_answer_matches(answer)
    return false unless answer.matches.size == matching_solutions.count

    hashed_matching_solutions = Hash.new { |h, k| h[k] = [] }
    matching_solutions.each do |matching_solution|
      hashed_matching_solutions[matching_solution.hashed_source] << matching_solution.hashed_target
    end

    hashed_answer_matches = Hash.new { |h, k| h[k] = [] }
    answer.matches.each do |match|
      hashed_answer_matches[match[0]] << [match[1]]
    end

    hashed_matching_solutions.each do |source, targets|
      unless hashed_answer_matches[source] == targets
        return false
      end
    end

    return true
  end

  def mass_assignment_authorizer(role = :default)
    super + [:matching_solutions_attributes]
  end
end
