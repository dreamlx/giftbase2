module Admin
  class StagesController < Admin::BaseController
    def index
      @stages = Stage.all
    end

    def show
      @stage = Stage.find(params[:id])
    end

    def new
      @stage = Stage.new
    end

    def edit
      @stage = Stage.find(params[:id])
    end

    def create
      @stage = Stage.new(params[:stage])

      if @stage.save
        redirect_to admin_stage_path(@stage), notice: t("success", scope: "flash.controller.create", model: Stage.model_name.human)
      else
        render action: "new"
      end
    end

    def update
      @stage = Stage.find(params[:id])

      if @stage.update_attributes(params[:stage])
        redirect_to admin_stage_path(@stage), notice: t("success", scope: "flash.controller.update", model: Stage.model_name.human)
      else
        render action: "edit"
      end
    end

    def destroy
      @stage = Stage.find(params[:id])
      @stage.destroy

      redirect_to admin_stages_url, notice: t("success", scope: "flash.controller.destroy", model: Stage.model_name.human)
    end
  end
end