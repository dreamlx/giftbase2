class GradesController < ApplicationController
  before_filter :create_cookies_role
  before_filter :authenticate_user!

  def index
    @grades = Grade.order(:position).all
  end

  def show
    @grade = Grade.find(params[:id])
 	  @stages = @grade.stages
  end

  private
  	def create_cookies_role
  	  cookies[:user_role] = params[:user_role] unless params[:user_role].nil?
  	end

end