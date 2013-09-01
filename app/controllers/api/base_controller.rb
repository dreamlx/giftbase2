module Api
  class BaseController < ApplicationController
    private 
    def wrong_item(exam)
		answers = Answer.where("exam_id = #{exam.id}")
	    answers.each do |answer|
	        if answer.point < answer.question_line_item.point
	          @wrong_answers.push(answer)
	        end
	  	end
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
