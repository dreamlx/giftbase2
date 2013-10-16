module Admin
  class ReportsController < Admin::BaseController
    def index
      @users= User.page(params[:page])
    end
  end
end
