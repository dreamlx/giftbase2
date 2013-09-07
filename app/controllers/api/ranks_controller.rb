module ExamRanking
  private 
    def exams_ranking(exams)
      total_point = 0
      sum_duration = 0
      @all_users_sum_duration = 0
      @all_users_sum_point = 0
      users_ranking = Array.new    #存储每个用户的信息 
      users = exams.select("user_id as id").group("user_id") #

      users.each do |user|
        if user.id != nil
          (exams.where("user_id = #{user.id}")).each do |exam|
            total_point += exam.total_point
            sum_duration += exam.duration
          end
        users_ranking.push({"avg_duration" => sum_duration/exams.size,
                "avg_point" => total_point/exams.size, "user_id" => user.id})
        end
      end

      users_ranking.each do |user_ranking|
        @all_users_sum_point += user_ranking["avg_point"]
        @all_users_sum_duration += user_ranking["avg_duration"]
      end

      if users_ranking.length != 0 
        @all_users_avg_point = @all_users_sum_point / users_ranking.length
        @all_users_sum_duration = @all_users_sum_duration / users_ranking.length
      end
      return users_ranking   
    end
end

module Api
  class RanksController < Api::BaseController
    before_filter :authenticate_user!

    include ExamRanking

    def ranking
      exams = Unit.find(params[:unit_id]).exams    unless params[:unit_id].blank?
      exams = Stage.find(params[:stage_id]).exams  unless params[:stage_id].blank?
      exams = Grade.find(params[:grade_id]).exams  unless params[:grade_id].blank?
      @users_ranking = exams_ranking(exams)
      @users_ranking.sort!{|a,b| [b['avg_point'], b['avg_duration']] <=> [a['avg_point'], b['avg_duration']]}
    end
  end
end

