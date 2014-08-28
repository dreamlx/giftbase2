module Api
  class UsersController < Api::BaseController
    respond_to :json
    def show
      user = User.find(params[:id])
      render json: {user: user}
    end

    def create
      user = User.new(params[:user])
      if user.save
        render json: { user: user}
      else
        render json: { user: user}
      end
    end

    def edit_username
      user = User.find(params[:id])
      if user.update_attribute(:username, params[:username])
        render json: {user: user}
      else
        render json: {user: user}
      end
    end

    def edit_gender
      user = User.find(params[:id])
      if user.update_attribute(:gender, params[:gender])
        render json: {user: user}
      else
        render json: {user: user}
      end    
    end

    def edit_phone
       user = User.find(params[:id])
      if user.update_attribute(:phone, params[:phone])
        render json: {user: user}
      else
        render json: {user: user}
      end       
    end

    def edit_school_name
       user = User.find(params[:id])
      if user.update_attribute(:school_name, params[:school_name])
        render json: {user: user}
      else
        render json: {user: user}
      end       
    end

    def edit_avatar
      user = User.find(params[:id])
      if user.update_attribute(:avatar, params[:avatar])
        render json: { user: user }
      else
        render json: { user: user }
      end
    end
  end
end
