module Admin
  class UnitsController < BaseController
    def index
      if current_user.role == 'admin'
        @units = Unit.all
      else
        @units = Unit.only_owner(current_user).all
      end
      #todo, need cancan 
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
  end
end
