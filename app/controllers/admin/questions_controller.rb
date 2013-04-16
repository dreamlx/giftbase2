module Admin
  class QuestionsController < BaseController
    def index
      @questions = Question.all
    end

    def show
      @question = Question.find(params[:id])
    end

    def new
      @question = Question.new_by_type(params[:type])
    end

    def edit
      @question = Question.find(params[:id])
    end

    def create
      type = params[:question].delete(:type)
      @question = Question.new_by_type(type, params[:question])

      if @question.save
        redirect_to admin_question_path(@question), notice: t("success", scope: "flash.controller.create", model: Question.model_name.human)
      else
        render action: "new"
      end
    end

    def update
      @question = Question.find(params[:id])
      params[:question].delete(:type)

      if @question.update_attributes(params[:question])
        redirect_to admin_question_path(@question), notice: t("success", scope: "flash.controller.update", model: Question.model_name.human)
      else
        render action: "edit"
      end
    end

    def destroy
      @question = Question.find(params[:id])
      @question.destroy

      redirect_to admin_questions_url, notice: t("success", scope: "flash.controller.destroy", model: Question.model_name.human)
    end
  end
end
