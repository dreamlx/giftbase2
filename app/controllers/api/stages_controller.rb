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

  end
end
