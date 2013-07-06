module Api
  class ExamsController < Api::BaseController
    before_filter :authenticate_user!

    def index
      @exams = current_user.exams
    end

    def create
      @exam = Exam.new(params[:exam])
      @exam.user = current_user

      if @exam.save
        render json: @exam, status: :created, location: api_exam_path(@exam)
      else
        render json: @exam.errors, status: :unprocessable_entity
      end
    end

    def show
      @exam = current_user.exams.find(params[:id])
    end
  end
end
