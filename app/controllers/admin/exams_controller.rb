module Admin
  class ExamsController < Admin::BaseController
    def index
      @exams = Exam.all
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

    def error
      @errors = Array.new
      @exam = Exam.find(params[:id])
      answers = Answer.where("exam_id = #{@exam.id}")
      answers.each do |answer|
        if answer.point < answer.question_line_item.point
          @errors.push(answer)
        end
      end
    end
  end
end
