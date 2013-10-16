module Admin
  class OrdersController < Admin::BaseController
    def index
      @orders = Order.page(params[:page])
    end

    def show
      @order = Order.find(params[:id])
    end
  end
end
