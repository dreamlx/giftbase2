module Admin
  class QuestionsController < Admin::BaseController
    def index
      @question_level_gteq = (params[:q] && params[:q][:question_level_id_gteq]) ? params[:q][:question_level_id_gteq].to_i : QuestionLevel.first.id
      @question_level_lteq = (params[:q] && params[:q][:question_level_id_lteq]) ? params[:q][:question_level_id_lteq].to_i : QuestionLevel.last.id
      @questions = (current_user.role == 'superadmin' ? Question.scoped : Question.only_owner(current_user))
      @q = @questions.only_owner(current_user).search(params[:q])
      if params[:question_id].blank?
        @questions = @q.result(distinct: true).order("questions.updated_at DESC").page(params[:page])
      else
        @questions = Question.where("id = #{params[:question_id]}").page(params[:page])
      end
    end

    def show
      @question = Question.find(params[:id])
      @units = @question.question_line_items.map{ |item| item.question_group.unit }
    end

    def new
      @question = Question.new_by_type(params[:type])
      session[:unit_id] = params[:unit_id]
      session[:group_id] = params[:group_id]
    end

    def edit
      @question = Question.find(params[:id])
    end

    def create
      type = params[:question].delete(:type)
      @question = Question.new_by_type(type, params[:question])

      if @question.save
        
        @question.belong_user(current_user)
        
        if session[:unit_id].blank? # Assert add question to unit
          redirect_to admin_question_path(@question), 
                    notice: t("success", 
                    scope: "flash.controller.create", 
                    model: Question.model_name.human) 
        else
          @unit = Unit.find(session[:unit_id])
          session[:unit_id] = ""    # TODO: Refactor with state_machine
          # add question group
          @question_group = @unit.question_groups.find(session[:group_id])
          session[:group_id] = ""
          @question_group.add_question(@question)
          
          redirect_to admin_unit_path(@unit)
        end
      else
        render action: "new"
      end
    end

    def update
      @question = Question.find(params[:id])
      params[:question].delete(:type)

      if @question.update_attributes(params[:question])
        redirect_to admin_question_path(@question), notice: t("success", scope: "flash.controller.update", model: Question.model_name.human)
      else
        render action: "edit"
      end
    end

    def destroy
      @question = Question.find(params[:id])
      @question.destroy

      redirect_to admin_questions_url, notice: t("success", scope: "flash.controller.destroy", model: Question.model_name.human)
    end

    def do_question
      @question = Question.find(params[:id])
    end

  end
end
