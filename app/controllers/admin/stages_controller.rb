module Admin
  class StagesController < Admin::BaseController
    def index
      @grades = Grade.all
      @stages = Stage.scoped
      @q = @stages.search(params[:q])
      @stages = @q.result(distinct: true).order("updated_at DESC")
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
    
    def stage_ranking
      @i = 0
      @stage = Stage.find(params[:id])
      @ranking_type = params[:ranking_type]
      @exams = @stage.exams
      @ranks = ranking

      respond_to do |format|
        format.js{render :action => "ranking_ajax"}
        format.html{render "/admin/ranking/stage_ranking" }
      end
    end
  end
end
