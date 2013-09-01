module Admin
  class StagesController < Admin::BaseController
    def index
      @stages = Stage.all
    end

    def show
      @stage = Stage.find(params[:id])
    end

    def new
      @stage = Stage.new
    end

    def edit
      @stage = Stage.find(params[:id])
    end

    def create
      @stage = Stage.new(params[:stage])

      if @stage.save
        redirect_to admin_stage_path(@stage), notice: t("success", scope: "flash.controller.create", model: Stage.model_name.human)
      else
        render action: "new"
      end
    end

    def update
      @stage = Stage.find(params[:id])

      if @stage.update_attributes(params[:stage])
        redirect_to admin_stage_path(@stage), notice: t("success", scope: "flash.controller.update", model: Stage.model_name.human)
      else
        render action: "edit"
      end
    end

    def destroy
      @stage = Stage.find(params[:id])
      @stage.destroy

      redirect_to admin_stages_url, notice: t("success", scope: "flash.controller.destroy", model: Stage.model_name.human)
    end
    
    def stage_ranking
      @i = 0
      @stage = Stage.find(params[:id])
      @ranking_type = params[:ranking_type]
      @exams = @stage.exams
      @ranks = ranking
      # @stage = Stage.find(params[:id])
      # @order_type = params[:order_type]
      # if @order_type.nil?
      #   @order_type = 1
      # end
      # @exams = @stage.exams
      # users = Array.new
      # @users_exam = Array.new
      # @result = Array.new
      # @exams.each do |e|
      #   users.push(e.user_id)
      # end
      # users.uniq!
      # users.delete(nil)
      # users.each do |u|
      #   @result.push(@exams.where("user_id=#{u}"))
      # end

      # point_sum = 0
      # duration_sum = 0
      # correct = 0
      # user_id = nil
      # @result.each do |res| #@result is grade's exams
      #   res.each do |r|
      #     @answers = Answer.where("exam_id = #{r.id}")
      #     @answers.each do |a|
      #       if a.point == a.question_line_item.point
      #         correct += 1
      #       end
      #     end
      #     point_sum += r.total_point
      #     duration_sum += r.duration.to_i/60
      #     user_id = r.user_id
      #   end
      #   answers_size = @stage.answers.where("user_id=#{user_id}").size
      #   @users_exam.push({"avg_point" => point_sum/res.size, "avg_duration" => duration_sum/res.size,
      #                     "user_id" => user_id, "accuracy" => (correct/answers_size).round(10) })
      # end
      # case @order_type
      #   when 1
      #     @users_exam.sort!{|a,b| [b["avg_point"], b["accuracy"], b["avg_duration"]] <=> 
      #                                [a["avg_point"], a["accuracy"], a["avg_duration"]] }
      #   when 2
      #     @users_exam.sort!{|a,b| [b["accuracy"], b["avg_point"], b["avg_duration"]] <=> 
      #                                [a["accuracy"], a["avg_point"], a["avg_duration"]] }
      #   when 3
      #     @users_exam.sort!{|a,b| [ b["avg_duration"], b["avg_point"], b["accuracy"]] <=> 
      #                               [a["avg_duration"], a["avg_point"], a["accuracy"]] }
      # end
         
      respond_to do |format|
        format.js{render :action => "ranking_ajax"}
        format.html{render "/admin/ranking/stage_ranking" }
      end
    end

    def wrong_answer
      @stage = Stage.find(params[:id])
      @wrong_answers_array = Array.new
      @exams = @stage.exams
      @exams.each do |exam|
        @wrong_answers = wrong_item(exam)
        @wrong_answers_array.push(@wrong_answers)
      end
      render "/admin/answers/wrong_answers", :object => @wrong_answers_array
    end
  end
end
