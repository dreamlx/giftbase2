class AlipayController < ApplicationController
  def notify
    @order = Order.find_by_number(params[:order_number])
    notification = ActiveMerchant::Billing::Integrations::Alipay::Notification.new(request.raw_post)
    
    transaction do
      if @order.can_pay? && notification.acknowledge
        @order.fire_state_event(:pay)
      end
    end

    render :text => "OK"
  end

  def done
    @order = Order.find_by_number(params[:order_number])
    result = ActiveMerchant::Billing::Integrations::Alipay::Return.new(request.query_string)

    transaction do
      if @order.can_pay? && result.success?
        @order.fire_state_event(:pay)
      end
    end

    redirect_to @order
  end
end
