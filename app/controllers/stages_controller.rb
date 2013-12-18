class StagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
    
  def index
    @stages = Stage.all
  end

  def show
    session[:return_to] = request.referer
    @stage = Stage.find(params[:id])
    @units = @stage.units
  end

  def purchase
    @stage = Stage.find(params[:id])
    if @stage.purchase(current_user)
      current_user.children.each do |child|
        child.stages << @stage
        @stage.units.each do |unit|
          child.units << unit
        end
      end
      redirect_to stage_path(@stage), notice: t("success", scope: "flash.controller.stages.purchase")
    else
      redirect_to stage_path(@stage), notice: t("failed", scope: "flash.controller.stages.purchase")
    end
  end

end
