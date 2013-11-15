
class AnswersController < Admin::BaseController
 
  def new
  	@exam = Exam.find(params[:exam_id])
  	@unit = Unit.find(@exam.unit_id)
  	@questions ||= @unit.questions
  	@question_line_items ||= @unit.question_line_items
    $i ||= 0
    if $i == @question_line_items.size 
      @question_line_item = @question_line_items[$i]
      @question = @question_line_item.question
    elsif 
      @question_line_item = @question_line_items[$i]
      @question = @question_line_item.question
      @answer = @exam.answers.build
      $i += 1
  	end    	
  end

  def create
  	$answers ||= Array.new
	@exam = Exam.find(params[:answer][:exam_id])
	if params[:commit] == 'prev'
	  $answers.pop
	  $i -= 1
	  redirect_to new_exam_answer_path(@exam)
	elsif params[:commit] == 'next'
	  $answers.push(params[:answer])
	  redirect_to new_exam_answer_path(@exam)
	elsif params[:commit] == 'all_submit'
	  $answers.push(params[:answer])
	  $answers.each do |answer|
	  	a = Answer.new(answer)
	  	a.save
	  end
	  @exam.auto_review
	  $i = 0
	  redirect_to score_exam_path(@exam)
	end     
  end
end
