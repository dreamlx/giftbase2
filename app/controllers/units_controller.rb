class UnitsController < ApplicationController
  before_filter :authenticate_user!
  def show
    session[:return_to] = request.referer
    @unit = Unit.find(params[:id])
  end

  def take_exam
  	@unit = Unit.find(params[:id])
  	if @unit.question_line_items.size != 0
  	  if params[:question_line_item_id].nil?    #直接点做题，读取第一题
        session[:answers] = Array.new 
        @question_line_item = @unit.question_line_items.order("position").first
        @question = @question_line_item.question
        @answer = Answer.new
      else
      	@question_line_item = QuestionLineItem.find(params[:question_line_item_id])
      	@question = @question_line_item.question
      	@answer = Answer.new
      end
    else
      redirect_to stage_path(@unit.stage), alert: "The unit has no question"
    end
  end
end
