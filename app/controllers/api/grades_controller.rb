module Api
  class GradesController < ApplicationController
    def index
      @grades = Grade.all
    end

    def show
      @grade = Grade.find(params[:id])
    end
  end
end
