module Api
  class CreditLineItemsController < Api::BaseController
    before_filter :authenticate_user!

    def index
    	credit = current_user.credit
    	@credit_line_items = credit.credit_line_items
    end
  end
end
