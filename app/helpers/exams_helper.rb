module ExamsHelper

  def user_answer(question_line_item, exam)
  	answer = question_line_item.answers.find_by_exam_id(exam.id)
  	question = question_line_item.question
  	if answer.nil?
     return Answer.human_attribute_name("user_answer_nil")
    else
      question.single_choice_options.to_enum.with_index(65).each do |op, i|
        return i.chr if answer.option_id.to_i == op.id
      end
    end
  end
end