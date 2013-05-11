module Api
  class ExamsController < ApplicationController
    def create
      @exam = Exam.new(params[:exam])

      if @exam.save
        render json: @exam, status: :created, location: api_exam_path(@exam)
      else
        render json: @exam.errors, status: :unprocessable_entity
      end
    end

    def show
      @exam = Exam.find(params[:id])
    end
  end
end
