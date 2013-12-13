class SessionsController < Devise::SessionsController
  def create
    cookies.delete(:user_role) unless cookies[:user_role].nil?
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render status: 200, json: { success: true, auth_token: resource.authentication_token, username: resource.username, avatar_id: resource.avatar_id } }
    end
  end

end
