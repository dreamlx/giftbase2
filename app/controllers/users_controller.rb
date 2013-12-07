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
      child = User.find_by_username(params[:user][:username])
      if child.nil?
        flash[:alert] = t("user_not_exist")
      else
        parent_child.child_id = child.id
        if parent_child.save
          flash[:alert] = t("make_sure_child")
        else
          flash[:alert] = t("aready_add_child")
        end
      end
    elsif params[:child] == "new"
      child = User.create(params[:user])
      child.email = child.username + "@xxxx.com"
      child.confirm!
      if child.save
        parent_child.child_id = child.id
        parent_child.verify_parent = true
        parent_child.save
        flash[:notice] = t("add_child_success")
      else
        flash[:alert] = child.errors.full_messages.to_sentence
      end
    end
    redirect_to parent_user_path(@parent)
  end

  def child_confirm_parent
    @child = current_user
    @parent = User.find(params[:id])
    child_parent = ChildParent.where(child_id: @child.id, parent_id: @parent.id).first
    child_parent.verify_parent = true
    if child_parent.save
      flash[:notice] = t("success_confirm_parent")
    else
      flash[:alert] = child_parent.full_messages.to_sentence
    end 
    redirect_to grades_path
  end

  def parent
    @parent = User.find(params[:id])
    @children = @parent.children
    @student = User.new
  end
end