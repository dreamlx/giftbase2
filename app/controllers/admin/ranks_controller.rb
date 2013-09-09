require 'api/ranks_controller'

module Admin
  class RanksController < Api::BaseController
    before_filter :authenticate_user!
    layout 'admin'

    include ExamRanking

    def ranking
      if !params[:unit_id].blank?
        @result = Unit.find(params[:unit_id])
        exams = @result.exams
        @wrong_answers_path = "link_to t('wrong_answer'),wrong_answers_admin_exam_path(@result, 
                              unit_id: @result.id, user_id: user_ranking['user_id']), method: :post"
      elsif !params[:stage_id].blank?
        @result = Stage.find(params[:stage_id])
        exams = @result.exams
        @wrong_answers_path = "link_to t('wrong_answer'),wrong_answers_admin_exam_path(@result, 
                              stage_id: @result.id, user_id: user_ranking['user_id']), method: :post"
      elsif !params[:grade_id].blank?
        @result = Grade.find(params[:grade_id])
        exams = @result.exams
        @wrong_answers_path = "link_to t('wrong_answer'),wrong_answers_admin_exam_path(@result, 
                                grade_id: @result.id, user_id: user_ranking['user_id']), method: :post"
      end
      @users_ranking = exams_ranking(exams)
      @users_ranking.sort!{|a,b| [b['avg_point'], b['avg_duration']] <=> [a['avg_point'], b['avg_duration']]}
      render "/admin/ranks/ranking"
    end
  end
end
