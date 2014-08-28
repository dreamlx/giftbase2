# coding: utf-8
module Api
  class UserTokensController < Api::BaseController
    respond_to :json
    def show
      user = User.find_by_authentication_token(params[:id])

      render json: { 
        user: user, 
        auth_token: user.authentication_token, 
        message: 'user.authentication_token'
      }
    end

    def create
      email     = params[:user_token][:email]
      password  = params[:user_token][:password]
      nickname  = params[:user_token][:nick_name]

      if email.nil? or password.nil?
        render :status=>400, :json=>{:error=>"The request must contain the user email and password."}
        return
      end
      
      user=User.find_by_email(email.downcase)
      
      if user.nil?
        logger.info("User #{email} failed signin, user cannot be found.")
        render :status => 401, :json => {:errors => { user: ['用户不存在']}  }
        return
      end
      
      # http://rdoc.info/github/plataformatec/devise/master/Devise/Models/TokenAuthenticatable
      user.ensure_authentication_token
      
      if user.valid_password?(password)
        render json: {
          user_token: {
            token: user.authentication_token,
            user_id: user.id
          },
          users: [
            {
            id:         user.id,
            email:      user.email,
            username:   user.username
            }
          ]
        }
      else
        logger.info("User #{email} failed signin, password \"#{password}\" is invalid")
        render :status=> :unauthorized, :json => {:errors => {password: ['密码错误']} }
      end
    end

    def destroy
      user = User.find_by_authentication_token( params[:id])
      if user.nil?
        logger.info("Token not found.")
        render :status => 404, :json => { :error=>"Invalid token" }
      else
        user.reset_authentication_token
        user.save
        render :status => 204, :json => { user: user, message: 'auth_token is empty now' }
      end
    end
  end
end
