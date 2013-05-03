module Api
  class QuestionGroupsController < ApplicationController
    before_filter :load_unit

    def index
      @question_groups = @unit.question_groups
    end

    def show
      @question_group = @unit.question_groups.find(params[:id])
    end

  protected

    def load_unit
      @unit = Unit.find(params[:unit_id])
    end
  end
end
