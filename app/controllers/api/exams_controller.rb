module WrongItem
  private 
  def wrong_item(exams)
    wrong_answers = Array.new
    exams.each do |exam|
      exam.answers.each do |answer|
        wrong_answers.push(answer) if answer.point < answer.question_line_item.point
      end
    end
    return wrong_answers
  end
end

module Api
  class ExamsController < Api::BaseController
    before_filter :authenticate_user!

    include WrongItem

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
      #试卷，单元，年级所有错题
      exams = Exam.where("id = #{params[:exam_id]}")    unless params[:exam_id].blank?
      exams = Unit.find(params[:unit_id]).exams    unless params[:unit_id].blank?
      exams = Stage.find(params[:stage_id]).exams  unless params[:stage_id].blank?
      exams = Grade.find(params[:grade_id]).exams  unless params[:grade_id].blank?
      # 我的错题
      exams.map!{ |e| e.user_id == params[:user_id] ? e : nil }  unless params[:user_id].blank?
      exams.compact!
      
      @wrong_answers = wrong_item(exams)
      render "/admin/answers/wrong_answers", :object => @wrong_answers
    end
  end
end
