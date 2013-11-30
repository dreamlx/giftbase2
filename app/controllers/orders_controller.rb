class OrdersController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @orders = current_user.orders.all
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def create
    @order = Order.new(credit_quantity: params[:credit_quantity])
    @order.user = current_user

    if @order.save
      redirect_to @order, notice: t("success", scope: "flash.controller.create", model: Order.model_name.human)
    else
      redirect_to credits_path, alert: t("failure", scope: "flash.controller.create", model: Order.model_name.human)
    end
  end

  def pay_by_cash
    @order = current_user.orders.find(params[:id])
    if @order.pay
      redirect_to orders_path, notice: t("success")
    else
      redirect_to orders_path, alert: t("failure")
    end
  end

  def pay
    @order = current_user.orders.find(params[:id])

    unless @order.can_pay?
      redirect_to @order
    end
  end
end
