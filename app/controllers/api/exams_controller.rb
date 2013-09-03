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

    def wrong_answers
      # 我的错题，现在是所有错题
      @exam = Exam.find(params[:id]) if params[:answer_range] == 'unit'
      @exam = Stage.find(params[:id]) if params[:answer_range] == 'stage'
      @exam = Grade.find(params[:id]) if params[:answer_range] == 'grade'
      @wrong_answers = Array.new
      wrong_item(@exam)
      render "/api/exams/wrong_answers"
    end

    private 
    def wrong_item(exam)
    answers = Answer.where("exam_id = #{exam.id}")
      answers.each do |answer|
        if answer.point < answer.question_line_item.point
          @wrong_answers.push(answer)
        end
    end
  end
end
