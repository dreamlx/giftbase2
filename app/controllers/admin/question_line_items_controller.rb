module Admin
  class QuestionLineItemsController < BaseController
    before_filter :load_unit_and_question_group

    def create
      
    end

    def update
      
    end

    def destroy
      
    end

    def move_higher
      @question_line_item = @question_group.question_line_items.find(params[:id])
      @question_line_item.move_higher

      redirect_to admin_unit_question_group_path(@unit, @question_group)
    end

    def move_lower
      @question_line_item = @question_group.question_line_items.find(params[:id])
      @question_line_item.move_lower

      redirect_to admin_unit_question_group_path(@unit, @question_group)
    end

  protected

    def load_unit_and_question_group
      @unit = Unit.find(params[:unit_id])
      @question_group = @unit.question_groups.find(params[:question_group_id])
    end

  end
end
