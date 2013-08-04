module Admin
  class PicturesController < Admin::BaseController
    before_filter :load_imageable
    
    def new
      @picture = Picture.new
    end

    def create
      @picture = Picture.new(params[:picture])
      @picture.imageable = @imageable

      if @picture.save
        redirect_to [:admin, @imageable], notice: t("success", scope: "flash.controller.create", model: Picture.model_name.human)
      else
        redirect_to [:admin, @imageable], alert: t("failure", scope: "flash.controller.create", model: Picture.model_name.human)
      end
    end

    def destroy
      @picture = @imageable.pictures.find(params[:id])
      @picture.destroy

      redirect_to [:admin, @imageable]
    end

  protected

    def load_imageable
      if params[:grade_id]
        @imageable = Grade.find(params[:grade_id])
      end
    end

  end
end
