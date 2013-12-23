class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    if resource.role == "admin"
      stored_location_for(resource) || admin_path
  	else
      grades_path
  	end
  end

end
