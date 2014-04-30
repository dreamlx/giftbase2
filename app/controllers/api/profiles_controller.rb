# coding: utf-8
module Api
  class ProfilesController < Api::BaseController
    before_filter :authenticate_user!

    def show
      @user = current_user
      render json: @user
    end

    def update
      @user                 = current_user
      @user.avatar          = params[:avatar] unless params[:avatar].blank?
      @user.avatar_id       = params[:avatar_id] unless params[:avatar_id].blank?
      @user.qq              = params[:qq] unless params[:qq].blank?
      @user.birthday        = params[:birthday] unless params[:birthday].blank?
      @user.home_address    = params[:home_address] unless params[:home_address].blank?
      @user.school_name     = params[:school_name] unless params[:school_name].blank?
      @user.school_address  = params[:school_address] unless params[:school_address].blank?
      @user.parent_name     = params[:parent_name] unless params[:parent_name].blank?
      @user.email     = params[:email] unless params[:email].blank?
      @user.username  = params[:username] unless params[:username].blank?
      @user.gender    = params[:gender] unless params[:gender].blank?
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
