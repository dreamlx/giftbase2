module Admin
  class ReviewsController < Admin::BaseController
    before_filter :load_data

    def show
    end

    def update
      @answer.point = params[:answer][:point] unless params[:answer][:point].blank?
      @answer.comment = params[:answer][:comment] unless params[:answer][:comment].blank?

      if @answer.save
        @answer.mark_as_reviewed!
        redirect_to admin_exam_review_path(exam_id: @exam, question_group_id: @question_group, question_line_item_id: @question_line_item), notice: t("success", scope: "flash.controller.admin.reviews.update")
      else
        redirect_to admin_exam_review_path(exam_id: @exam, question_group_id: @question_group, question_line_item_id: @question_line_item), alert: t("failure", scope: "flash.controller.admin.reviews.update")
      end
    end

    protected

    def load_data
      @exam = Exam.find(params[:exam_id])
      @unit = @exam.unit
      @question_group = @unit.question_groups.find(params[:question_group_id])
      @question_line_item = @unit.question_line_items.find(params[:question_line_item_id])
      @question = @question_line_item.question
      @answer = @exam.answers.find_by_question_line_item_id(@question_line_item)

      @previous_question_group = @question_group.higher_item
      @next_question_group = @question_group.lower_item

      @previous_question_line_item = @question_line_item.higher_item
      @next_question_line_item = @question_line_item.lower_item
    end
  end
end
