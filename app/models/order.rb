class Order < ActiveRecord::Base
  belongs_to :user

  attr_accessible :credit_quantity

  validates :user, presence: true

  before_validation :generate_number, on: :create

  state_machine :state, initial: :placed do
    state :placed, :paid, :canceled

    event :pay do
      transition :placed => :paid
    end
    after_transition :placed => :paid, :do => [:update_credit]

    event :cancel do
      transition :placed => :canceled
    end
  end

  before_save :update_total

protected

  def generate_number
    if self.number.blank?
      record = true
      while record
        random = rand(1000000000).to_s.rjust(9, '0')
        record = self.class.where(number: random).first
      end
      self.number = random
    end
    self.number
  end

  def update_credit
    self.user.credit.add_income(self)
  end

  def update_total
    self.total = Credit.price_of(credit_quantity)
  end
end
