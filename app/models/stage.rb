class Stage < ActiveRecord::Base
  has_many :units
  has_and_belongs_to_many :users
  
  attr_accessible :description, :name, :price

  validates :name, :price, presence: true

  def purchase(user)
    if (!user.stages.include?(self)) && user.credit.balance > self.price
      user.credit.add_expense(self)
      user.stages << self
    end
  end
end
