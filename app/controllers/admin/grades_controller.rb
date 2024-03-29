module Admin
  class GradesController < Admin::BaseController
    def index
      @grades = Grade.order(:position).all
    end

    def show
      @grade = Grade.find(params[:id])
    end

    def new
      @grade = Grade.new
    end

    def edit
      @grade = Grade.find(params[:id])
    end

    def create
      @grade = Grade.new(params[:grade])

      if @grade.save
        redirect_to admin_grade_path(@grade), notice: t("success", scope: "flash.controller.create", model: Grade.model_name.human)
      else
        render action: "new"
      end
    end

    def update
      @grade = Grade.find(params[:id])

      if @grade.update_attributes(params[:grade])
        redirect_to admin_grade_path(@grade), notice: t("success", scope: "flash.controller.update", model: Grade.model_name.human)
      else
        render action: "edit"
      end
    end

    def destroy
      @grade = Grade.find(params[:id])
      @grade.destroy

      redirect_to admin_grades_url, notice: t("success", scope: "flash.controller.destroy", model: Grade.model_name.human)
    end
  end
end
