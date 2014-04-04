module Api
  class StagesController < Api::BaseController
    before_filter :authenticate_user!, only: [:mine, :purchase]

    def index
      @stages = Stage.order(:position).all
    end

    def show
     @stage = Stage.find(params[:id])

     #
     user = User.find(params[:user_id])
     @stage.units.each { |u| u.lock_state = :lock }
     
     #first
     @stage.units.first.lock_state = :unlock
     #examed
     @stage.units.each { |u| u.lock_state = :unock if user.exams.any? {|exam| exam.unit.id == u.id} }
     #last passed
     
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
