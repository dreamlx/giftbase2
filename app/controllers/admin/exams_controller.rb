require "api/exams_controller"

module Admin
  class ExamsController < Admin::BaseController
    include WrongItem
    
    def index
      @exams = Exam.page(params[:page])
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

    def wrong_answers
      exams = Exam.where("id = #{params[:exam_id]}")    unless params[:exam_id].blank?
      exams = Unit.find(params[:unit_id]).exams    unless params[:unit_id].blank?
      exams = Stage.find(params[:stage_id]).exams  unless params[:stage_id].blank?
      exams = Grade.find(params[:grade_id]).exams  unless params[:grade_id].blank?
      # 我的错题
      exams.map!{ |e| e.user_id == params[:user_id] ? e : nil }  unless params[:user_id].blank?
      exams.compact!
      
      @wrong_answers = wrong_item(exams)
      render "/admin/answers/wrong_answers", :object => @wrong_answers
    end

    private 
    def wrong_item(exams)
      wrong_answers = Array.new
      exams.each do |exam|
        exam.answers.each do |answer|
          wrong_answers.push(answer) if answer.point < answer.question_line_item.point
        end
      end
      return wrong_answers
    end
  end
end