class GradesController < ApplicationController
  def index
    @grades = Grade.order(:position).all
  end

  def show
    @grade = Grade.find(params[:id])
 	@stages = @grade.stages
  end
end