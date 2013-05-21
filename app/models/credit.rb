class Credit < ActiveRecord::Base
  belongs_to :user

  default_value_for :start_balance, 0
  default_value_for :balance, 0

  def self.bundles
    [100, 200, 500, 1000]
  end

  def self.price_of(quantity)
    quantity / 10
  end
end
