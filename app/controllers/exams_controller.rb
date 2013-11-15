
class ExamsController < ApplicationController
  
  def new
    @unit = Unit.find(params[:unit_id])
    @exam = @unit.exams.build
    @exam.user_id = current_user.id
    @exam.save
    @question = @unit.questions.first
    @question_line_item = @unit.question_line_items.first
    @answer = @exam
  end

  def create
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
