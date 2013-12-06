class UsersController < ApplicationController

  def study_record
  	@exams = current_user.exams
  end

  def study_record_chart
  	@take_exam_time_for_day = Hash.new 
  	@exams = current_user.exams
  	@exams.each do |exam|
      time = exam.created_at.strftime("%y/%m/%d")
      if @take_exam_time_for_day[time].nil?
      	@take_exam_time_for_day[time] = exam.duration/60
      else
      	@take_exam_time_for_day[time] += exam.duration/60 
      end 
  	end
  	respond_to do |format|
      format.json {render json: @take_exam_time_for_day.to_json}
      format.html 
  	end
  end

  def study_schedule
    @stages = current_user.stages
  end

  def parent_add_child
    @parent = User.find(params[:id])
    parent_child = @parent.child_parents.build
    if params[:child] == "old"
    elsif params[:child] == "new"
      child = User.create(params[:user])
      if child.save
        parent_child.child_id = child.id
        parent_child.save
        redirect_to parent_user_path(@parent)
      else
        redirect_to parent_user_path(@parent)
      end
    end
  end

  def parent
    @parent = User.find(params[:id])
    @children = @parent.children
    @student = User.new
  end
end