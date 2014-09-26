# coding: utf-8
module Api
  class UserTokensController < Api::BaseController
    respond_to :json
    def show
      user = User.find_by_authentication_token(params[:id])

      render json: { user: user, auth_token: user.authentication_token, message: 'user.authentication_token', error: 1, msg: "succeed"} #, status: 200
    end

    def create

      if params[:user][:login].nil? || params[:user][:password].nil?
        render json: {error: 0, msg: t('login_or_password_not_nil')}
        return
      end
      user=User.find_by_email(params[:user][:login].downcase) || User.find_by_username(params[:user][:login])
      
      if user && user.valid_password?(params[:user][:password])

        # http://rdoc.info/github/plataformatec/devise/master/Devise/Models/TokenAuthenticatable
        user.ensure_authentication_token

        render json: {
          error: 1,
          msg: "succeed",
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
        } #, status: 201
      else
        render json: {error: 0, msg: t('wrong_login_or_password')}
      end
    end

    def destroy
      user = User.find_by_authentication_token( params[:id])
      if user.nil?
        logger.info("Token not found.")
        render json:{error: 0, msg: "Invalid token" }
      else
        user.reset_authentication_token
        user.save
        render json: { user: user, error: 1, msg: 'succeed' }
      end
    end
  end
end
