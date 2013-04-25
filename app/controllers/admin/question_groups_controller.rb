module Admin
  class QuestionGroupsController < BaseController
    before_filter :load_unit

    def show
      @question_group = @unit.question_groups.find(params[:id])

      @question_level_gteq = (params[:q] && params[:q][:level_gteq]) ? params[:q][:level_gteq].to_i : 1
      @question_level_lteq = (params[:q] && params[:q][:level_lteq]) ? params[:q][:level_lteq].to_i : 4
      @q = Question.not_in_unit(@unit).only_owner(current_user).search(params[:q])
      @questions = @q.result(distinct: true).order("updated_at DESC")
    end

    def new
      @question_group = QuestionGroup.new
    end

    def edit
      @question_group = @unit.question_groups.find(params[:id])
    end

    def create
      @question_group = QuestionGroup.new(params[:question_group])
      @question_group.unit = @unit

      if @question_group.save
        redirect_to admin_unit_path(@unit), notice: t("success", scope: "flash.controller.create", model: QuestionGroup.model_name.human)
      else
        render action: "new"
      end
    end

    def update
      @question_group = @unit.question_groups.find(params[:id])

      if @question_group.update_attributes(params[:question_group])
        redirect_to admin_unit_path(@unit), notice: t("success", scope: "flash.controller.update", model: QuestionGroup.model_name.human)
      else
        render action: "edit"
      end
    end

    def destroy
      @question_group = @unit.question_groups.find(params[:id])
      @question_group.destroy

      redirect_to admin_unit_path(@unit), notice: t("success", scope: "flash.controller.destroy", model: QuestionGroup.model_name.human)
    end

    def move_higher
      @question_group = @unit.question_groups.find(params[:id])
      @question_group.move_higher

      redirect_to admin_unit_path(@unit)
    end

    def move_lower
      @question_group = @unit.question_groups.find(params[:id])
      @question_group.move_lower

      redirect_to admin_unit_path(@unit)
    end

    def add_question
      @question_group = @unit.question_groups.find(params[:id])
      @question = Question.find(params[:question_id])
      @question_group.add_question(@question)
      redirect_to admin_unit_question_group_path(@unit, @question_group)
    end

    def remove_question
      @question_group = @unit.question_groups.find(params[:id])
      @question = Question.find(params[:question_id])
      @question_group.remove_question(@question)
      redirect_to admin_unit_question_group_path(@unit, @question_group)
    end

  protected

    def load_unit
      @unit = Unit.find(params[:unit_id])
    end
  end
end
