class GradesController < ApplicationController
  before_filter :create_cookies_role
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @grades = Grade.order(:position).all
  end

  def show
    @grade = Grade.find(params[:id])
 	  @stages = @grade.stages
  end

  def mine
    @grades = current_user.grades
  end

  def purchase
    @grade = Grade.find(params[:id])
    if @grade.purchase(current_user)
      current_user.children.each do |child|
        set_grade_to_child(child, @grade)
      end
      redirect_to grade_path(@grade), notice: t("success", scope: "flash.controller.grades.purchase")
    else
      redirect_to grade_path(@grade), notice: t("failed", scope: "flash.controller.grades.purchase")
    end
  end

  def set_grade_to_child(child, grade)
    @grade.stages.each do |stage|
      stage.units.each do |unit|
        child.units << unit
      end
      child.stages << stage
    end
    child.grades << @grade 
  end

  private
  	def create_cookies_role
  	  cookies[:user_role] = params[:user_role] unless params[:user_role].nil?
  	end

end