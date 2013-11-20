class AnswersController < Admin::BaseController
 
  def new
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
    @unit = Unit.find(params[:unit_id])
  	if params[:commit] == 'pre'
  	  session[:answers].pop
      question_line_item = QuestionLineItem.find(params[:answer][:question_line_item_id])
      if !@unit.pre_question_line_item(question_line_item.position).nil? #get pre question_line_item
        question_line_item = @unit.pre_question_line_item(question_line_item.position) 
      end
      redirect_to take_exam_unit_path(@unit, question_line_item_id: question_line_item.id)
  	elsif params[:commit] == 'next'
  	  session[:answers].push(params[:answer]) unless params[:answer][:option_id].nil?
      question_line_item = QuestionLineItem.find(params[:answer][:question_line_item_id])
      if !@unit.next_question_line_item(question_line_item.position).nil?   #get next question_line_item
        question_line_item = @unit.next_question_line_item(question_line_item.position) 
      end
  	  redirect_to take_exam_unit_path(@unit, question_line_item_id: question_line_item.id)
  	elsif params[:commit] == 'all_submit'
      exam = Exam.create!(unit_id:@unit.id, user_id: current_user.id)
      session[:answers].push(params[:answer]) unless params[:answer][:option_id].nil? 
  	  session[:answers].each do |answer|
  	  	a = Answer.new(answer)
        a.exam_id = exam.id
  	  	a.save
  	  end
  	  exam.auto_review
      session.delete(:answers)
  	  redirect_to score_exam_path(exam)
  	end     
  end
end
