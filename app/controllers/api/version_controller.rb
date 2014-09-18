class Api::VersionController < Api::BaseController
  def version
    render json: {version: Rails.application.config.VERSION }
  end
end