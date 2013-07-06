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
          format.json { render status: :unprocessable_entity, json: { success: false } }
        end
      end
    else
      clean_up_passwords resource
      respond_to do |format|
        format.html { }
        format.json { render status: :unprocessable_entity, json: { success: false } }
      end
    end
  end
end
