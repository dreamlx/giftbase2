module Api
  class UsersController < Api::BaseController
    # before_filter :authenticate_user_from_token!, only: [:destroy, :update]
    respond_to :json
    def show
      user = User.find(params[:id])
      render json: {user: user}, status: 200
    end

    def create
      user = User.new(params[:user])
      if user.save
        render json: { user: user}, status: 201
      else
        render json: {errors: user.errors}, status: 401
      end
    end

    def update
      user = User.find(params[:id])
      if user.update_attributes(params[:user])
        render json: { user: user}, status: 201, message: "updated success"
      else
        render json: { user: user}, status: 400, message: "updated failed"
      end
    end
  end
end
