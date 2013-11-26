class UsersController < ApplicationController

  def study_record
  	@exams = current_user.exams
  end

  def study_record_chart
  end

  def study_schedule
    @stages = current_user.stages
  end
end