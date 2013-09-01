
module Api
  class UnitsController < Api::BaseController
    before_filter :authenticate_user!, only: [:mine]
    
    def index
      @units = Unit.all
    end

    def show
      @unit = Unit.find(params[:id])
    end

    def mine
      @units = current_user.stages.map(&:units).flatten.compact.uniq

      render 'index'
    end

    def unit_ranking
      @unit = Unit.find(params[:id])
      @exams = @unit.exams
      @ranks = ranking
      @ranks.sort!{|a,b| [b['avg_point'], b['avg_duration']] <=> [a['avg_point'], b['avg_duration']]}
      render "/api/ranking/ranking"
    end

    def wrong_answers
      @unit = Unit.find(params[:id])
      @wrong_answers = Array.new
      @exams = @unit.exams
      @exams.each do |exam|
        wrong_item(exam)
      end
      render "/api/exams/wrong_answers"
    end
  end
end
