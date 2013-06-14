require 'active_merchant'
require 'active_merchant/billing/integrations/action_view_helper'
ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper)


ActiveMerchant::Billing::Integrations::Alipay::ACCOUNT = 'your_alipay_id'
ActiveMerchant::Billing::Integrations::Alipay::KEY = 'your_alipay_key'
ActiveMerchant::Billing::Integrations::Alipay::EMAIL = 'your_alipay_email'
