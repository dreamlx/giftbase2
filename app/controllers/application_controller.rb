class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    if resource.role == "admin"
      stored_location_for(resource) || admin_path
  	elsif resource.role == "student"
      grades_path
  	elsif  resource.role == "father" || resource.role == "mother"
      parent_user_path(resource)
  	end
  end
end
