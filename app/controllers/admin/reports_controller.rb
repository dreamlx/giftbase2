module Admin
  class ReportsController < BaseController
    def index
      @users= User.all
    end
  end
end