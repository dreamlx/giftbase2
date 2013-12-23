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
        if unit.id == stage.units.first.id
          unit.unlock(child)
        end
      end
      child.stages << stage
    end
    child.grades << @grade
    @grade.stages.first.unlock(child) #first stage is unlock
    @grade.stages.first.units.first.unlock(child) # first unit is unlock
  end

  private
  	def create_cookies_role
  	  cookies[:user_role] = params[:user_role] unless params[:user_role].nil?
  	end

end