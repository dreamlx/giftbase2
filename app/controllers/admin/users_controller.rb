module Admin
  class UsersController < Admin::BaseController
    def index
      @users = User.all
    end

    def new
      @user = User.new
    end

    def edit
      @user = User.find(params[:id])
    end

    def create
      @user = User.new(params[:user])

      if @user.save
        redirect_to admin_users_path, notice: t("success", scope: "flash.controller.create", model: User.model_name.human)
      else
        render action: "new"
      end
    end

    def update
      if params[:user][:password].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
        params[:user].delete(:current_password)
      end
      if params[:user][:username].blank?
        params[:user].delete("username")
      end
      @user = User.find(params[:id])
      if @user.update_attributes(params[:user])
        redirect_to admin_users_path, notice: t("success", scope: "flash.controller.update", model: User.model_name.human)
      else
        render action: "edit"
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy

      redirect_to admin_users_url, notice: t("success", scope: "flash.controller.destroy", model: User.model_name.human)
    end
  end
end