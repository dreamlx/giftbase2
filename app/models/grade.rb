class Grade < ActiveRecord::Base
  has_many :stages, order: 'stages.position'
  has_many :units, through: :stages, order: "units.position"
  has_many :questions, through: :units
  has_many :exams, through: :units
  has_many :answers, through: :exams
  has_many :pictures, as: :imageable, dependent: :destroy
  has_many :user_grades
  has_many :user, through: :user_grades

  attr_accessible :description, :name, :position, :state

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
      # self.stages.first.unlock(user)
      self.stages.first.units.first.unlock(user) # first unit is unlock
      true
    else
      false
    end
  end

  def purchase?(user)
    user.blank? ? false : user.grades.include?(self) 
  end

end
