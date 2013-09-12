module Api
  class ProfilesController < Api::BaseController
    before_filter :authenticate_user!

    def show
      @user = current_user
      render json: @user
    end

    def update
      @user             = current_user
      @user.avatar      = params[:avatar] unless params[:avatar].blank?
      @user.qq          = params[:qq] unless params[:qq].blank?
      @user.birthday    = params[:birthday] unless params[:birthday].blank?
      @user.address         = params[:address] unless params[:address].blank?
      @user.school_name     = params[:school_name] unless params[:school_name].blank?
      @user.school_address  = params[:school_address] unless params[:school_address].blank?
      @user.parent_name     = params[:parent_name] unless params[:parent_name].blank?
      @user.email     = params[:email] unless params[:email].blank?
      if @user.save!
        render json: @user
      else
        render json: @user.errors
      end
    end

    def upload_avatar
      @user = current_user
      @user.avatar = params[:avatar]
      if @user.save!
        render json: @user
      else
        render json: @user.errors
      end
    end
  end
end
