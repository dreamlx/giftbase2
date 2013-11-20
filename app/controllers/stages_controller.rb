class StagesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @stages = Stage.all
  end

  def show
    session[:return_to] = request.referer
    @stage = Stage.find(params[:id])
    @units = @stage.units
  end

  def purchase
    @stage = @grade.stages.find(params[:id])
    @stage.purchase(current_user)

    redirect_to stage_path(@stage), notice: t("success", scope: "flash.controller.stages.purchase")
  end

end
