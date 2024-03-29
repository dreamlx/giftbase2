# coding: utf-8
module Api
  class ProfilesController < Api::BaseController
    before_filter :authenticate_user!
    def index
      @users = User.all
      render json: @users
    end

    def about_me
      @user = current_user
      render json: @user
    end

    def show
      @user = User.find(params[:id])
      render json: @user
    end

    def update
      @user                 = User.find(params[:id])

      if @user.update_attributes(params[:user])
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
