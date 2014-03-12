class Question < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  has_many :question_line_items
  has_one :user_question
  has_one :user, through: :user_question
  belongs_to :question_level
  
  amoeba do
    enable
  end
  attr_accessible :hint, :subject, :image, :image_cache, :question_level_id

  validates :subject, :question_level_id, presence: true

  #scope :in_same_grade, lambda { |grade| grade.question_ids.blank? ? scoped : where('id NOT IN (?)', grade.question_ids) }
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

  def can_auto_review?
    false
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
    self.question_level.name
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
