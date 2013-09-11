module Api
  class GradesController < Api::BaseController
    def index
      @grades = Grade.includes([:stages]).all
    end

    def show
      @grade = Grade.find(params[:id])
    end
  end
end
