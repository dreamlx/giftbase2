module Admin
  class OrdersController < Admin::BaseController
    def index
      @orders = Order.all
    end

    def show
      @order = Order.find(params[:id])
    end
  end
end
