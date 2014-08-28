module Api
  class UsersController < Api::BaseController
    respond_to :json
    def show
      user = User.find(params[:id])
      render json: {user: user}
    end

    def create
      # user = User.new(user_params)
      user = User.new()
      user.username = params[:user][:username]
      user.email    = params[:user][:email]
      user.password = params[:user][:password]
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

    private
      def user_params
        params.require(:user).permit(:username, :password, :email)
      end
  end
end
