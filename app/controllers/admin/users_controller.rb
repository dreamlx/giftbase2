module Admin
  class UsersController < Admin::BaseController
    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
    end

    def create
      @user = User.new(params[:user])
      @user.save

      redirect_to admin_user_path(@user)
    end
  end
end