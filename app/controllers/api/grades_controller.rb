module Api
  class GradesController < Api::BaseController
    def index
      @grades = Grade.all
    end

    def show
      @grade = Grade.find(params[:id])
    end

    def grade_ranking
      @grade = Grade.find(params[:id])
      @exams = @grade.exams
      @ranks = ranking
      @ranks.sort!{|a,b| [b['avg_point'], b['avg_duration']] <=> [a['avg_point'], b['avg_duration']]}
      render "/api/ranking/ranking"
    end
    
    def wrong_answers
      @grade = Grade.find(params[:id])
      @wrong_answers = Array.new
      @exams = @grade.exams
      @exams.each do |exam|
        wrong_item(exam)
      end
      render "/api/exams/wrong_answers"
    end
  end
end
