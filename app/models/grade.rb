class Grade < ActiveRecord::Base
  has_many :stages, order: 'stages.position'
  has_many :units, through: :stages, order: "units.position"
  has_many :exams, through: :units
  has_many :answers, through: :exams
  has_many :pictures, as: :imageable, dependent: :destroy
  has_and_belongs_to_many :users

  attr_accessible :description, :name, :position

  def purchase(user)
    if (!user.grades.include?(self)) && user.credit.balance > self.stages.sum(:price)
      user.credit.add_expense_grade(self)
      user.grades << self
      self.stages.each do |stage|
        user.stages << stage
        stage.units.each do |unit|
          user.units << unit
        end
      end
      true
    else
      false
    end
  end

  def purchase?(user)
    user.blank? ? false : user.grades.include?(self) 
  end

end
