class GradesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @grades = Grade.order(:position).all
  end

  def show
    @grade = Grade.find(params[:id])
 	@stages = @grade.stages
  end
end