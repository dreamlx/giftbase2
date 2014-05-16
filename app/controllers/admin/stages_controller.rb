module Admin
  class StagesController < Admin::BaseController
    def index
      @grades = Grade.all
      @stages = Stage.scoped.order([:position, :name])
      @q = @stages.search(params[:q])
      @stages = @q.result(distinct: true).order("updated_at DESC").page(params[:page])
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

    def move_higher
      @stage = Stage.find(params[:id])
      @stage.move_higher

      redirect_to admin_stages_path
    end

    def move_lower
      @stage = Stage.find(params[:id])
      @stage.move_lower

      redirect_to admin_stages_path
    end

    #
    def random
      random_name = t("random", scope: "stage")
      stage_id = params[:id]

      if Unit.where(stage_id: stage_id, name: random_name).size > 0 

        flash[:notice] = t('repeat', scope: 'flash')

      else

        random_count = 10
        qid_array = Question.select('id').where(stage_id: stage_id).map{|x| x.id}

        Unit.transaction  do
          #unit new
          unit = Unit.new
          unit.stage_id = stage_id
          unit.name = random_name
          unit.exam_minutes = 30
          unit.save!
          #group new
          group = QuestionGroup.new
          group.name = random_name
          group.unit = unit
          group.save!
          #qli
          qid_a2 = qid_array.shuffle[0...random_count]
          qid_a2.each{|q|
            qli = QuestionLineItem.new
            qli.question_id = q
            qli.question_group = group
            qli.save!
          }
        end

        flash[:notice] = t('success', scope: 'flash') 

      end
      
      redirect_to admin_stage_path
    
    end

  end
end
