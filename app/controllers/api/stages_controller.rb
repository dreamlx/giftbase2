module Api
  class StagesController < Api::BaseController
    before_filter :authenticate_user!, only: [:mine, :purchase]

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

    def purchase
      @stage = Stage.find(params[:id])
      if @stage.purchase(current_user)
        render json: "success", status: 200
      else
        render json: "failed, no enough money or have paid", status: :unprocessable_entity
      end
    end
  end
end
