module Api
  class ProfilesController < Api::BaseController
    before_filter :authenticate_user!

    def show
      @user = current_user
    end
  end
end
