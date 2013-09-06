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

    def wrong_answer
      @wrong_answers_array = Array.new
      @exam = Exam.find(params[:id])
      @wrong_answers_array.push(wrong_item(@exam))
      render "/admin/answers/wrong_answers", :object => @wrong_answers_array
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



def wrong_answers
  #试卷，单元，年级所有错题
  @exams = Unit.find(params[:unit_id]).exams    unless params[:unit_id].blank?
  @exams = Stage.find(params[:stage_id]).exams  unless params[:stage_id].blank?
  @exams = Grade.find(params[:grade_id]).exams  unless params[:grade_id].blank?
  # 我的错题
  @exams = User.find(params[:user_id]).exams  unless params[:user_id].blank?
  @wrong_answers = wrong_item(@exams)
  render "/api/exams/wrong_answers"
end

  