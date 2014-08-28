module Api
  class BaseController < ApplicationController
    private
      def authenticate_user_from_token!
        user_token = params[:auth_token].presence
        user = user_token && User.find_by_authentication_token(user_token)
        if user
          sign_in user, store: false
        else
          render json: { message: "please login"}
        end
      end
  end    
end
