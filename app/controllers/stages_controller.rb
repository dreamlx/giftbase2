class StagesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @stages = Stage.all
  end

  def show
    @stage = Stage.find(params[:id])
  end

  def purchase
    @stage = Stage.find(params[:id])
    @stage.purchase(current_user)

    redirect_to stage_path(@stage), notice: t("success", scope: "flash.controller.stages.purchase")
  end
end
