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
  end
end
