module Api
  class RanksController < Api::BaseController
    before_filter :authenticate_user!
    # TODO,需要讨论
    def unit_ranking
      @i = 0
      @unit = Unit.find(params[:id])
      @exams = Exam.where("unit_id = #{@unit.id}")
      @ranks = ranking
      @ranks.sort!{|a,b| [b['avg_point'], b['avg_duration']] <=> [a['avg_point'], b['avg_duration']]}
      render "/admin/ranking/unit_ranking"     
    end

    def stage_ranking
      @i = 0
      @stage = Stage.find(params[:id])
      @ranking_type = params[:ranking_type]
      @exams = @stage.exams
      @ranks = ranking

      respond_to do |format|
        format.js{render :action => "ranking_ajax"}
        format.html{render "/admin/ranking/stage_ranking" }
      end
    end

    def grade_ranking
      @grade = Grade.find(params[:id])
      @exams = @grade.exams
      @ranks = ranking
      @ranks.sort!{|a,b| [b['avg_point'], b['avg_duration']] <=> [a['avg_point'], b['avg_duration']]}
      render "/api/ranking/ranking"
    end
    
    private 
    def ranking
    total_point = 0
    sum_duration = 0
    @all_users_sum_duration = 0
    @all_users_sum_point = 0
    ranks = Array.new 
    @users = @exams.select("user_id as id").group("user_id")
    @users.each do |user|
      if user.id != nil
        (@exams.where("user_id = #{user.id}")).each do |exam|
          total_point += exam.total_point
          sum_duration += exam.duration
        end
      ranks.push({"avg_duration" => sum_duration/@exams.size,
              "avg_point" => total_point/@exams.size, "user_id" => user.id})
      end
    end
    ranks.each do |rank|
      @all_users_sum_point += rank["avg_point"]
      @all_users_sum_duration += rank["avg_duration"]
    end
    if ranks.length != 0
      @all_users_avg_point = @all_users_sum_point / ranks.length
      @all_users_sum_duration = @all_users_sum_duration / ranks.length
    end
    return ranks   
    end 
  end
end
