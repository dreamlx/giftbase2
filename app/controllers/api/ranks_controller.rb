module ExamRanking
  private 
    def exam_rankings(exams)
      total_point = 0
      sum_duration = 0
      @all_users_sum_duration = 0
      @all_users_sum_point = 0
      user_rankings = Array.new    #存储每个用户的信息

      user_ids = exams.select("user_id as id").group("user_id") 

      user_ids.each do |user_id|
        if user_id.id
          exams.where("user_id = #{user_id.id}").each do |exam|
            total_point += exam.total_point
            sum_duration += exam.duration
          end
        user_rankings.push(
          user: User.find(user_id.id),
          sum_duration: sum_duration.to_i, 
          avg_duration: (sum_duration / exams.size).to_f,
          total_point: total_point.to_i, 
          avg_point: (total_point / exams.size).to_f, 
          exam_sizes: exams.size,
          users_count: user_ids.size
          )
        end
      end

      return user_rankings   
    end

    def sum_ranking(sum_items, sum_colum)
      sum = 0
      sum_items.each{|r| sum += r[sum_colum]}

      return sum
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
      @user_rankings = exam_rankings(exams)
      @user_rankings.sort!{|a,b| [b['avg_point'], b['avg_duration']] <=> [a['avg_point'], b['avg_duration']]}

      @alluser_total_point = sum_ranking(@user_rankings, :total_point)
      @alluser_sum_duration = sum_ranking(@user_rankings, :sum_duration)
      @all_exam_sizes = sum_ranking(@user_rankings, :exam_sizes)
      @alluser_avg_point = @all_exam_sizes > 0 ? (@alluser_total_point / @all_exam_sizes) : 0
      @alluser_avg_duration = @all_exam_sizes > 0 ? (@alluser_sum_duration / @all_exam_sizes) : 0
      
      render json: { 
        user_rankings: @user_rankings,
        alluser_total_point: @alluser_total_point,
        alluser_sum_duration: @alluser_sum_duration,
        all_exam_sizes: @all_exam_sizes,
        alluser_avg_point: @alluser_avg_point,
        alluser_avg_duration: @alluser_avg_duration
      }
    end
  end
end

