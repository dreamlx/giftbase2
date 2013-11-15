
class AnswersController < Admin::BaseController
 
  def new
  	@exam = Exam.find(params[:exam_id])
  	@unit = Unit.find(@exam.unit_id)
    if session[:record_answer_id] == session[:question_line_item_ids].size
      @question_line_item = QuestionLineItem.find(session[:question_line_item_ids][session[:record_answer_id]])
      @question = @question_line_item.question
    else
      binding.pry
      @question_line_item = QuestionLineItem.find(session[:question_line_item_ids][session[:record_answer_id]])
      @question = @question_line_item.question
      @answer = @exam.answers.build
      session[:record_answer_id] += 1
  	end    	
  end

  def create
  	@exam = Exam.find(params[:exam_id])
  	if params[:commit] == 'prev'
  	  cookies[:answers].pop
  	  session[:record_answer_id] -= 1
  	  redirect_to new_exam_answer_path(@exam)
  	elsif params[:commit] == 'next'
  	  cookies[:answers].push(params[:answer])
  	  redirect_to new_exam_answer_path(@exam)
  	elsif params[:commit] == 'all_submit'
      cookies[:answers].push(params[:answer])
  	  cookies[:answers].each do |answer|
  	  	a = Answer.new(answer)
  	  	a.save
  	  end
  	  @exam.auto_review
  	  cookies[:record_answer_id] = 0
  	  redirect_to score_exam_path(@exam)
  	end     
  end
end
