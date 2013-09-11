module Api
  class GradesController < Api::BaseController
    def index
      @grades = Grade.order("name desc").all
    end

    def show
      @grade = Grade.find(params[:id])
    end
  end
end
