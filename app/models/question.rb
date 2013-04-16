class Question < ActiveRecord::Base
  has_many :question_line_items
  
  attr_accessible :hint, :level, :subject

  validates :subject, :level, presence: true

  scope :not_in_unit, lambda { |unit| unit.question_ids.blank? ? scoped : where('id NOT IN (?)', unit.question_ids) }

  def self.new_by_type(type_name, attrs = {})
    result = safe_type_name(type_name).constantize.new(attrs)
    result.build_relative
    result
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
