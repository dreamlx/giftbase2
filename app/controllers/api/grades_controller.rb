# coding: UTF-8
module Api
  class GradesController < Api::BaseController
    def index
      if params[:state].blank? or params[:state].nil?
        @grades = Grade.order("position").where(state: 'publish')
      else
        @grades = Grade.order("position").all
      end

      return @grades
    end

    def show
      @grade = Grade.find(params[:id])
    end
  end
end
