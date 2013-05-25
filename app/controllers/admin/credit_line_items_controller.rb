module Admin
  class CreditLineItemsController < Admin::BaseController
    def index
      @credit_line_items = CreditLineItem.all
    end

    def with_order
      @credit_line_items = CreditLineItem.with_order

      render 'index'
    end

    def with_stage
      @credit_line_items = CreditLineItem.with_stage
      
      render 'index'
    end

    def show
      @credit_line_item = CreditLineItem.find(params[:id])
    end
  end
end
