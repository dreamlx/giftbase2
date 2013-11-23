
class ExamsController < ApplicationController
  
  def new
    @unit = Unit.find(params[:unit_id])
    @exam = @unit.exams.build
    @exam.user_id = current_user.id
    @exam.save
    session[:question_line_items] ||= {:unit_id => @unit.id, :ids => []}
    # session[:exam_id] ||= Exam.last.id + 1
    # @exam.id = session[:exam_id]
    # session[:exam_id] += 1
    session[:question_line_items] = {:unit_id => @unit.id, :ids => []}
    @unit.question_line_items.each do |question_line_item|
      session[:question_line_items][:ids].push(question_line_item.id)
    end
    session[:record_answer_id] = 0
    session[:answers] = Array.new 
    redirect_to new_exam_answer_path(@exam) 
  end

  def create
  end

  def score
    @exam = Exam.find(params[:id])
  end

  def start_review
    @exam = Exam.find(params[:id])
    @question_group = @exam.unit.question_groups.first
    @question_line_item = @question_group.question_line_items.first

    redirect_to admin_exam_review_path(exam_id: @exam, question_group_id: @question_group, question_line_item_id: @question_line_item)
  end

  def finish_review
    @exam = Exam.find(params[:id])

    if @exam.can_finish_review?
      redirect_to admin_exam_path(@exam), notice: t("success", scope: "flash.controller.admin.exams.finish_review")
    else
      redirect_to admin_exam_path(@exam), alert: t("failure", scope: "flash.controller.admin.exames.finish_review")
    end
  end

  def show
    @exam = Exam.find(params[:id])
  end
end
