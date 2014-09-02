module WrongItem
  private 
    def wrong_item(exams)
      wrong_answers = Array.new
      exams.each do |exam|
        exam.answers.each do |answer|
          #wrong_answers.push(answer) if answer.point < answer.question_line_item.point
          id = answer.data[:option_id]
          wrong_answers.push(answer) if SingleChoiceOption.find(id).correct == false
        end
      end
      return wrong_answers
    end
end

module Api
  class ExamsController < Api::BaseController
    # before_filter :authenticate_user_from_token!

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

    def question_group
      question_group = Question.all.sample(250)
      question_group_json = Array.new
      question_group.each do |item|
        item_json           = item.as_json
        item_json[:options] = item.single_choice_options.as_json
        question_group_json << item_json
      end
      render json: {question_group: question_group_json}, status: 200
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

      exams.map!{ |e| e.user_id == current_user.id ? e : nil }
      exams.compact!
      
      @wrong_answers = wrong_item(exams)
      render "/api/exams/wrong_answers"
    end

    def redo
      exam = Exam.new(params[:exam])
      exam.answers.each do |answer|
        id = answer.data[:option_id]
        option = SingleChoiceOption.find(id)
        if option.correct == true
          qid = option.question_id
          user_id = current_user.id
          sql = "select a.id from answers a, question_line_items q, exams e
                  where 
                   e.user_id = ? and
                   e.id = a.exam_id and 
                   a.question_line_item_id = q.id and 
                   q.question_id = ? "
          past_answers = Answer.find_by_sql [sql, user_id, qid]
          past_answers.each do |a|
            past_answer = Answer.find a.id
            past_answer.data = answer.data
            past_answer.save!
          end
        end
      end      
      render json: {}
    end
  end
end
