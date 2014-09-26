module Api
  class UsersController < Api::BaseController
    before_filter :authenticate_user_from_token!, only: [:show, :update]
    respond_to :json
    def show
      user = User.find(params[:id])
      render json: {user: user, error: 1, msg: "succeed"} #, status: 200
    end

    def profile
      user = User.find_by_authentication_token(params[:auth_token])
      user_json  = user.as_json
      user_json[:topscore] = user.scores.maximum(:number)
      render json: {user: user_json, error: 1, msg: "succeed"} #, status: 200
    end

    def create
      user = User.new(params[:user])
      if user.save
        render json: { user: user, auth_token: user.authentication_token, error: 1, msg: "succeed"} #, status: 201
      else
        render json: {error: 0, msg: format_error_message(user.errors)} #, status: 401
      end
    end

    def update
      user = User.find(params[:id])
      if user.update_attributes(params[:user])
        render json: { user: user, error: 1, msg: "succeed"} #, status: 201, message: "updated success"
      else
        render json: { user: user, error: 0, msg: format_error_message(user.errors)} #, status: 400, message: "updated failed"
      end
    end
  end
end
