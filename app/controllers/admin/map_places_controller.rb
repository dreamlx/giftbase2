module Admin
  class MapPlacesController < Admin::BaseController
    before_filter :load_placeable
    
    def new
      @map_place = MapPlace.new
    end

    def create
      @map_place = MapPlace.new(params[:map_place])
      @map_place.placeable = @placeable

      if @map_place.save
        redirect_to [:admin, @placeable], notice: t("success", scope: "flash.controller.create", model: MapPlace.model_name.human)
      else
        redirect_to [:admin, @placeable], alert: t("failure", scope: "flash.controller.create", model: MapPlace.model_name.human)
      end
    end

    def destroy
      @map_place = @placeable.map_places.find(params[:id])
      @map_place.destroy

      redirect_to [:admin, @placeable]
    end

  protected

    def load_placeable
      if params[:stage_id]
        @placeable = Stage.find(params[:stage_id])
      elsif params[:unit_id]
        @placeable = Unit.find(params[:unit_id])
      end
    end

  end
end
