module Admin
  class ReportsController < Admin::BaseController
    def index
      @users= User.all
    end
  end
end
