class AnswersController < Admin::BaseController
 
  def new
  	@exam = Exam.find(params[:exam_id])
  	@unit = Unit.find(@exam.unit_id)
    if session[:record_answer_id] == session[:question_line_items][:ids].size
      @question_line_item = QuestionLineItem.find(session[:question_line_items][:ids][session[:record_answer_id]])
      @question = @question_line_item.question
    else
      @question_line_item = QuestionLineItem.find(session[:question_line_items][:ids][session[:record_answer_id]])
      @question = @question_line_item.question
      @answer = @exam.answers.build
      session[:record_answer_id] += 1
  	end    	
  end

  def create
  	@exam = Exam.find(params[:answer][:exam_id])
  	if params[:commit] == 'prev'
  	  session[:answers].pop
  	  session[:record_answer_id] -= 2
  	  redirect_to new_exam_answer_path(@exam)
  	elsif params[:commit] == 'next'
  	  session[:answers].push(params[:answer]) unless params[:answer][:option_id].nil?
  	  redirect_to new_exam_answer_path(@exam)
  	elsif params[:commit] == 'all_submit'
      session[:answers].push(params[:answer]) unless params[:answer][:option_id].nil? 
  	  session[:answers].each do |answer|
  	  	a = Answer.new(answer)
  	  	a.save
  	  end
  	  @exam.auto_review
      session.delete(:record_answer_id)
      session.delete(:answers)
      session.delete(:question_line_items)
  	  redirect_to score_exam_path(@exam)
  	end     
  end
end
