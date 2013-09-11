module Api
  class GradesController < Api::BaseController
  	caches_page :index
    def index
      @grades = Grade.includes([:stages]).all
    end

    def show
      @grade = Grade.find(params[:id])
    end
  end
end
