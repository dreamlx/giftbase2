module Api
  class QuestionLineItemsController < ApplicationController
    before_filter :load_unit, :load_question_group

    def index
      @question_line_items = @question_group.question_line_items
    end

    def show
      @question_line_item = @question_group.question_line_items.find(params[:id])
    end

  protected

    def load_unit
      @unit = Unit.find(params[:unit_id])
    end

    def load_question_group
      @question_group = @unit.question_groups.find(params[:question_group_id])
    end
  end
end
