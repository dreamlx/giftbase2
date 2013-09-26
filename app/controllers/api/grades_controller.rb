module Api
  class GradesController < Api::BaseController
    def index
      grades = Grade.order("name").all
      @grades = []
      
      grades.each {|g| @grades << g if g.pictures.size > 0 }

      return @grades
    end

    def show
      @grade = Grade.find(params[:id])
    end
  end
end
