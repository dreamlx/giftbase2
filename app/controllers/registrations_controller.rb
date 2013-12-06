class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource
    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_to do |format|
          format.html { redirect_to after_sign_up_path_for(resource) }
          format.json { render status: 200, json: { success: true, auth_token: resource.authentication_token } }
        end
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_to do |format|
          format.html { redirect_to after_inactive_sign_up_path_for(resource) }
          format.json { render status: :unprocessable_entity, json: { success: false, error_message: resource.errors } }
        end
      end
    else
      clean_up_passwords resource
      respond_to do |format|
        format.html{respond_with resource}
        format.json { render status: :unprocessable_entity, json: { success: false, error_message: resource.errors } }
      end
    end
  end

  def update
    # required for settings form to submit when password is left blank
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
      params[:user].delete(:current_password)
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      
      respond_to do |format|
        format.html { redirect_to after_update_path_for(@user) }
        format.json { render status: 200 }
      end
    else
      respond_to do |format|
        format.html { render "edit" }
        format.json { render status: :unprocessable_entity, json: { success: false, error_message: @user.errors } }
      end
    end
  end
end
