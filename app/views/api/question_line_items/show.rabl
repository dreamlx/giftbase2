object @question_line_item
attributes :id, :position, :point

node(:question_type) do |question_line_item|
  question_line_item.question.type
end

child(:question => :question) do |question|
  attributes :id, :subject, :hint, :type, :level

  case question.type
  when 'Question::Brief'
    child(:brief_solution) do
      attributes :id, :content
    end

  when 'Question::FillInBlank'
    child(:fill_in_blank_solutions) do
      attributes :content, :position
    end

  when 'Question::Matching'
    child(:matching_solutions) do
      attributes :source, :target, :hashed_source, :hashed_target
    end

  when 'Question::MultipleChoice'
    child(:multiple_choice_options) do
      attributes :id, :content, :correct, :position, :sequence
    end

  when 'Question::SingleChoice'
    child(:single_choice_options) do
      attributes :id, :content, :correct, :position, :sequence
    end

  end
end
