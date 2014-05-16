module Admin
  class UnitsController < Admin::BaseController
    def index
      @stages = Stage.all
      @units = (current_user.role == 'superadmin' ? Unit.scoped : Unit.only_owner(current_user))
      @q = @units.search(params[:q])
      @units = @q.result(distinct: true).order("updated_at DESC").page(params[:page])
    end

    def show
      @unit = Unit.find(params[:id])
    end

    def copy
      unit = Unit.find(params[:id])
      unit2 = unit.amoeba_dup
      unit2.name += '=>copy'

      if unit2.save
        unit2.belong_user(current_user)
        redirect_to admin_unit_path(unit2), 
                        notice: t("success", 
                          scope: "flash.controller.copy", 
                          model: Unit.model_name.human)
      else
        redirect_to admin_unit_path(unit), 
                        notice: t("failure", 
                          scope: "flash.controller.copy", 
                          model: Unit.model_name.human)
      end
    end

    def new
      @unit = Unit.new
    end

    def edit
      @unit = Unit.find(params[:id])
    end

    def create
      @unit = Unit.new(params[:unit])

      if @unit.save
        redirect_to admin_unit_path(@unit), 
                      notice: t("success", 
                      scope: "flash.controller.create", 
                      model: Unit.model_name.human)
        @unit.belong_user(current_user)  
      else
        render action: "new"
      end
    end
    
    def update
      @unit = Unit.find(params[:id])

      if @unit.update_attributes(params[:unit])
        redirect_to admin_unit_path(@unit), notice: t("success", scope: "flash.controller.update", model: Unit.model_name.human)
      else
        render action: "edit"
      end
    end

    def destroy
      @unit = Unit.find(params[:id])
      @unit.destroy

      redirect_to admin_units_url, notice: t("success", scope: "flash.controller.destroy", model: Unit.model_name.human)
    end

    def update_by_ajax
      @unit = Unit.find(params[:id])
      @unit.stage_id = params[:stage_id]
      if @unit.save
        respond_to do |format|
          format.js
        end
      else
        render action: "edit"
      end
    end

    #
    def trans
      @unit = Unit.find(params[:id])
    end

    def ajax_unit
      stage = params[:stage]
      units = Stage.find(stage).units.map{|u| [u.id, u.name]}
      respond_to do |format|
          format.json { render json: units.to_s }
      end
    end

    def ajax_group
      unit = params[:unit]
      groups = Unit.find(unit).question_groups.map{|g| [g.id, g.name]}
      respond_to do |format|
          format.json { render json: groups.to_s }
      end
    end

    def trans_do
      qli_ids = params[:qlis]

      qlis = []
      qli_ids.try(:each){|x| qlis << QuestionLineItem.find(x)}

      qg = params[:question_group]
      if qg.blank?

          flash[:notice] = t(:trans_select_group, scope: 'flash.question')

      else

        qlis.each do |e|
          e.question_group_id = qg
          if ! e.save!
            flash[:notice] = t(:false_id, scope: 'flash.question') + e.id.to_s
          end
        end

      end
      redirect_to trans_admin_unit_path
    end


  end
end
