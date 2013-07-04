module Api
  class CreditsController < Api::BaseController
    before_filter :authenticate_user!

    def show
      @credit = current_user.credit
    end
  end
end
