# coding: UTF-8
module Api
  class GradesController < Api::BaseController
    def index
      grades = Grade.order("position").where(state: 'publish')
      @grades = []
      # todo: 改为status处理
      grades.each {|g| @grades << g if g.pictures.size > 0 }

      return @grades
    end

    def show
      @grade = Grade.find(params[:id])
    end
  end
end
