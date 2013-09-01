module Api
  class StagesController < Api::BaseController
    before_filter :authenticate_user!, only: [:mine]

    def index
      @stages = Stage.all
    end

    def show
      @stage = Stage.find(params[:id])
    end

    def mine
      @stages = current_user.stages

      render 'index'
    end

    def stage_ranking
      @stage = Stage.find(params[:id])
      @exams = @stage.exams
      @ranks = ranking
      @ranks.sort!{|a,b| [b['avg_point'], b['avg_duration']] <=> [a['avg_point'], b['avg_duration']]}
      render "/api/ranking/ranking"
    end

    def wrong_answers
      @stage = Stage.find(params[:id])
      @wrong_answers = Array.new
      @exams = @stage.exams
      @exams.each do |exam|
        wrong_item(exam)
      end
      render "/api/exams/wrong_answers"
    end

  end
end
