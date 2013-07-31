module Api
  class ProfilesController < Api::BaseController
    before_filter :authenticate_user!

    def show
      @user = current_user
      render json: @user
    end

    def update
      @user = current_user
      @user.avatar = params[:avatar]
      @user.save!
      render json: @user
    end
  end
end
