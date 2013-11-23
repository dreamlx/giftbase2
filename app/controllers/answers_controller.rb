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
  	if params[:commit] == t("previous_question_line_item")
  	  pre_question_line_item
  	elsif params[:commit] == t("next_question_line_item")
  	  next_question_line_item
  	elsif params[:commit] == t("all_submit")
      all_submit
  	end     
  end

  private
    def pre_question_line_item
      session[:answers].pop
        question_line_item = QuestionLineItem.find(params[:answer][:question_line_item_id])
        if !@unit.pre_question_line_item(question_line_item.position).nil? #get pre question_line_item
          question_line_item = @unit.pre_question_line_item(question_line_item.position) 
        end
        redirect_to take_exam_unit_path(@unit, question_line_item_id: question_line_item.id)
    end

    def next_question_line_item
      session[:answers].push(params[:answer]) 
        question_line_item = QuestionLineItem.find(params[:answer][:question_line_item_id])
        if !@unit.next_question_line_item(question_line_item.position).nil?   #get next question_line_item
          question_line_item = @unit.next_question_line_item(question_line_item.position) 
        end
        redirect_to take_exam_unit_path(@unit, question_line_item_id: question_line_item.id)
    end

    def all_submit
      exam = Exam.create!(unit_id:@unit.id, user_id: current_user.id)
      session[:answers].push(params[:answer])
      last_question_line_item = @unit.question_line_items.order("position").last
      if params[:answer][:question_line_item] != last_question_line_item.id
        question_line_item = QuestionLineItem.find((params[:answer][:question_line_item_id]))
        while question_line_item.position < last_question_line_item.position
          question_line_item = @unit.next_question_line_item(question_line_item.position)
          session[:answers].push({question_line_item_id: question_line_item.id})
        end
      end

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
