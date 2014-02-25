module Admin
  class QuestionLevelsController < Admin::BaseController
    def index
      @question_levels = QuestionLevel.all
    end

    def new
      @question_level = QuestionLevel.new
    end

    def edit
      @question_level = QuestionLevel.find(params[:id])
    end

    def create
      @question_level = QuestionLevel.new(params[:question_level])

      if @question_level.save
        redirect_to admin_question_levels_path, notice: t("success", scope: "flash.controller.create", model: QuestionLevel.model_name.human)
      else
        render action: "new"
      end
    end

    def update
      @question_level = QuestionLevel.find(params[:id])

      if @question_level.update_attributes(params[:question_level])
        redirect_to admin_question_levels_path, notice: t("success", scope: "flash.controller.update", model: QuestionLevel.model_name.human)
      else
        render action: "edit"
      end
    end

    def destroy
      @question_level = QuestionLevel.find(params[:id])
      @question_level.destroy

      redirect_to admin_question_levels_url, notice: t("success", scope: "flash.controller.destroy", model: QuestionLevel.model_name.human)
    end
  end
end