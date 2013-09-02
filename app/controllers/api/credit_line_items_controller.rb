module Api
  class CreditLineItemsController < Api::BaseController
    before_filter :authenticate_user!

    def index
    	@credit_line_items = CreditLineItem.all
    end
  end
end
