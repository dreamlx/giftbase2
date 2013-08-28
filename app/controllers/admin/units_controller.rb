module Admin
  class UnitsController < Admin::BaseController
    def index
      @stages = Stage.all
      @units = if current_user.role == 'admin'
        Unit.scoped
      else
        Unit.only_owner(current_user)
      end
      @q = @units.search(params[:q])
      @units = @q.result(distinct: true).order("updated_at DESC")
    end

    def show
      @unit = Unit.find(params[:id])
    end

    def new
      @unit = Unit.new
    end

    def edit
      @unit = Unit.find(params[:id])
    end

    def create
      @unit = Unit.new(params[:unit])

      if @unit.save
        redirect_to admin_unit_path(@unit), 
                      notice: t("success", 
                      scope: "flash.controller.create", 
                      model: Unit.model_name.human)
        @unit.belong_user(current_user)  

      else
        render action: "new"
      end
    end

    def update
      @unit = Unit.find(params[:id])

      if @unit.update_attributes(params[:unit])
        redirect_to admin_unit_path(@unit), notice: t("success", scope: "flash.controller.update", model: Unit.model_name.human)
      else
        render action: "edit"
      end
    end

    def destroy
      @unit = Unit.find(params[:id])
      @unit.destroy

      redirect_to admin_units_url, notice: t("success", scope: "flash.controller.destroy", model: Unit.model_name.human)
    end

    def update_by_ajax
      @unit = Unit.find(params[:id])
      @unit.stage_id = params[:stage_id]
      if @unit.save
        respond_to do |format|
          format.js
        end
      else
        render action: "edit"
      end
    end

    def order_by_point
      @i = 0
      @unit = Unit.find(params[:id])
      @exams = Exam.all
      @exams.sort!{|a,b| [b.total_point,b.duration.to_i] <=>  [a.total_point,b.duration.to_i]}
    end
  end
end
