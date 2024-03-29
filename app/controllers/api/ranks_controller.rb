module ExamRanking
  private 
    def exam_rankings(exams)
      total_point = 0
      sum_duration = 0
      @all_users_sum_duration = 0
      @all_users_sum_point = 0
      user_rankings = Array.new    #存储每个用户的信息

      exam_groups = exams.group_by{ |e| e.user_id }
      
      exam_groups.each do |item|
        user_id = item.first
        exams = item.last
        exams.each do |exam|
          total_point += exam.total_point unless exam.total_point.nil?
          sum_duration += exam.duration
        end
        user_rankings.push(
          user: User.find(user_id),
          sum_duration: sum_duration.to_i, 
          avg_duration: (sum_duration / exams.size).to_f,
          total_point: total_point.to_i, 
          avg_point: (total_point / exams.size).to_f, 
          exam_sizes: exams.size,
          users_count: exam_groups.size
         ) 
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
      @user_rankings.sort!{|a,b| [b['avg_point'], b['avg_duration']] <=> [a['avg_point'], a['avg_duration']]}

      @index_with_rankings = Array.new
      @current_user_ranking = Hash.new
      @user_rankings.each_with_index do |key, index|
        key[:ranking_no] = @user_rankings.size - index.to_i 
        @current_user_ranking = key if key[:user].id == current_user.id
        @index_with_rankings << key if index < 3
      end
      
      @alluser_total_point = sum_ranking(@user_rankings, :total_point)
      @alluser_sum_duration = sum_ranking(@user_rankings, :sum_duration)
      @all_exam_sizes = sum_ranking(@user_rankings, :exam_sizes)
      @alluser_avg_point = @all_exam_sizes > 0 ? (@alluser_total_point / @all_exam_sizes) : 0
      @alluser_avg_duration = @all_exam_sizes > 0 ? (@alluser_sum_duration / @all_exam_sizes) : 0
      
      render json: { 
        user_rankings: @index_with_rankings.reverse,
        alluser_total_point: @alluser_total_point,
        alluser_sum_duration: @alluser_sum_duration,
        all_exam_sizes: @all_exam_sizes,
        alluser_avg_point: @alluser_avg_point,
        alluser_avg_duration: @alluser_avg_duration,
        current_user_ranking: @current_user_ranking
      }
    end
  end
end

