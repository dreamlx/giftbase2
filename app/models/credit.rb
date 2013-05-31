class Credit < ActiveRecord::Base
  belongs_to :user
  has_many :credit_line_items, order: 'created_at'

  default_value_for :start_balance, 0
  default_value_for :balance, 0

  def self.bundles
    [100, 200, 500, 1000]
  end

  def self.price_of(quantity)
    quantity / 10
  end

  def add_income(order)
    self.credit_line_items.create(amount: order.credit_quantity, order: order)
  end

  def add_expense(stage)
    self.credit_line_items.create(amount: -(stage.price), stage: stage)
  end

  def update_balance
    self.balance = credit_line_items.map(&:amount).sum
    self.save!
  end
end
