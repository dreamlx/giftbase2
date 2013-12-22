class CreditLineItem < ActiveRecord::Base
  belongs_to :credit
  belongs_to :order
  belongs_to :stage
  belongs_to :grade
  attr_accessible :amount, :order, :stage, :grade

  scope :with_order, lambda { where('order_id is not null') }
  scope :with_stage, lambda { where('stage_id is not null') }

  validates :amount, :credit, presence: true

  after_create :update_credit

protected

  def update_credit
    self.credit.update_balance
  end
end
