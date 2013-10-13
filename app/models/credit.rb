class Credit < ActiveRecord::Base
  belongs_to :user
  has_many :credit_line_items, order: 'created_at'

  #TODO: 默认值应该是0，这里以后需要手工调整
  default_value_for :start_balance, 1000
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
    self.balance = credit_line_items.map(&:amount).sum + self.start_balance
    self.save!
  end
end
