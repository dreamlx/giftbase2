module Admin
  class GradesController < Admin::BaseController
    def index
      @grades = Grade.all
    end

    def show
      @grade = Grade.find(params[:id])
    end

    def new
      @grade = Grade.new
    end

    def edit
      @grade = Grade.find(params[:id])
    end

    def create
      @grade = Grade.new(params[:grade])

      if @grade.save
        redirect_to admin_grade_path(@grade), notice: t("success", scope: "flash.controller.create", model: Grade.model_name.human)
      else
        render action: "new"
      end
    end

    def update
      @grade = Grade.find(params[:id])

      if @grade.update_attributes(params[:grade])
        redirect_to admin_grade_path(@grade), notice: t("success", scope: "flash.controller.update", model: Grade.model_name.human)
      else
        render action: "edit"
      end
    end

    def destroy
      @grade = Grade.find(params[:id])
      @grade.destroy

      redirect_to admin_grades_url, notice: t("success", scope: "flash.controller.destroy", model: Grade.model_name.human)
    end

    def ranking
      @i = 0
      @grade = Grade.find(params[:id])
      @order_type = params[:order_type]
      if @order_type.nil?
        @order_type = 1
      end
      @exams = @grade.exams
      users = Array.new
      @users_exam = Array.new
      @result = Array.new
      @exams.each do |e|
        users.push(e.user_id)
      end
      users.uniq!
      users.delete(nil)
      users.each do |u|
        @result.push(@exams.where("user_id=#{u}"))
      end

      point_sum = 0
      duration_sum = 0
      correct = 0
      user_id = nil
      @result.each do |res| #@result is grade's exams
        res.each do |r|
          @answers = Answer.where("exam_id = #{r.id}")
          @answers.each do |a|
            if a.point == a.question_line_item.point
              correct += 1
            end
          end
          point_sum += r.total_point
          duration_sum += r.duration.to_i/60
          user_id = r.user_id
        end
        answers_size = @grade.answers.where("user_id=#{user_id}").size
        @users_exam.push({"avg_point" => point_sum/res.size, "avg_duration" => duration_sum/res.size,
                          "user_id" => user_id, "accuracy" => (correct/answers_size).round(10) })
      end
      case @order_type
        when 1
          @users_exam.sort!{|a,b| [b["avg_point"], b["accuracy"], b["avg_duration"]] <=> 
                                     [a["avg_point"], a["accuracy"], a["avg_duration"]] }
        when 2
          @users_exam.sort!{|a,b| [b["accuracy"], b["avg_point"], b["avg_duration"]] <=> 
                                     [a["accuracy"], a["avg_point"], a["avg_duration"]] }
        when 3
          @users_exam.sort!{|a,b| [ b["avg_duration"], b["avg_point"], b["accuracy"]] <=> 
                                    [a["avg_duration"], a["avg_point"], a["accuracy"]] }
      end
      respond_to do |format|
        format.js{render :action => "ranking_ajax"}
        format.html
      end
    end

  end
end
