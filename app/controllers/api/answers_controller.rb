module Api
  class AnswersController < Api::BaseController
    before_filter :authenticate_user!, :load_exam

    def update
      @answer = @exam.answers.find(params[:id])

      if @answer.update_attributes(params[:answer])
        head :no_content
      else
        render json: @answer.errors #, status: :unprocessable_entity
      end
    end

    def show
      @answer = @exam.answers.find(params[:id])
    end

    protected

    def load_exam
      @exam = current_user.exams.find(params[:exam_id])
    end
  end
end
