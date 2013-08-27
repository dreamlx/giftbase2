
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

    def order
      @unit = Unit.find(params[:id])
      @exams = Exam.all
      @exams.sort!{|a,b| [b.total_point,b.duration.to_i] <=>  [a.total_point,b.duration.to_i]}
    end
  end
end
