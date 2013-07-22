module Api
  class ExamsController < Api::BaseController
    before_filter :authenticate_user!

    def index
      @exams = current_user.exams
    end

    def create
      @exam = Exam.new(params[:exam])
      @exam.user = current_user
      if @exam.unit_id.nil? or @exam.unit_id.blank?
        render json: {:errors =>"unit id can't null"}, status: :unprocessable_entity
      elsif @exam.save
        render json: @exam, status: :created, location: api_exam_path(@exam)
      else
        render json: @exam.errors, status: :unprocessable_entity
      end
    end

    def show
      @exam = current_user.exams.find(params[:id])
    end

    def finish_uploading
      @exam = current_user.exams.find(params[:id])

      if @exam.can_finish_uploading?
        @exam.fire_state_event(:finish_uploading)
      end
      render json: @exam
    end
  end
end
