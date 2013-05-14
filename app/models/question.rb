class Question < ActiveRecord::Base
  has_many :question_line_items
  has_one :user_question
  has_one :user, through: :user_question
  
  attr_accessible :hint, :level, :subject

  validates :subject, :level, presence: true

  scope :not_in_unit, lambda { |unit| unit.question_ids.blank? ? scoped : where('id NOT IN (?)', unit.question_ids) }
  scope :only_owner, lambda { |user| user.question_ids.blank? ? where('id is null') : where('id IN (?)', user.question_ids) }
  
  def belong_user(user)
    item = UserQuestion.new(user_id: user.id, question_id: self.id) 
    item.save
  end
  
  def self.new_by_type(type_name, attrs = {})
    result = safe_type_name(type_name).constantize.new(attrs)
    result.build_relative
    result
  end

  def auto_review(answer)
    
  end

  def self.instanceable?
    false
  end

  def build_relative
    self
  end

  def human_level
    I18n.t(level.to_s, scope: 'question_level')
  end
end

Dir["#{File.dirname(__FILE__)}/#{File.basename(__FILE__, '.*')}/**/*.rb"].each { |f| require_dependency f }

class Question
  def self.instanceable_classes
    klasses = [Question]
    index = 0
    while klasses[index]
      klasses += klasses[index].subclasses
      index += 1
    end
    klasses.select { |c| c.instanceable? }
  end

  def self.safe_type_name(type_name)
    instanceable_classes.map(&:name).include?(type_name) ? type_name : nil
  end
end
