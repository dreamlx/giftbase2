class Answer < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  belongs_to :exam
  belongs_to :question_line_item

  delegate :question, to: :question_line_item

  store :data, accessors: [ :option_id, :option_ids, :content, :contents, :matches ]
  
  attr_accessible :comment, :exam_id, :point, :reviewed_at, :image, :image_cache, :question_line_item_id, :option_id, :option_ids, :content, :contents, :matches

  scope :unreviewed, lambda { where('reviewed_at IS NULL') }
  scope :reviewed, lambda { where('reviewed_at NOT NULL') }

  default_value_for :point, 0

  validates :point, presence: true

  before_save :fix_point

  def max_point
    10#question_line_item.try(point)
  end

  def max_point?
    self.point == max_point
  end

  def reviewed?
    !(reviewed_at.blank?)
  end

  def auto_review
    question.auto_review(self)
  end

  def mark_as_reviewed!
    self.update_attribute(:reviewed_at, Time.zone.now) unless reviewed?
  end

  def can_change_point?
    !question.can_auto_review?
  end

protected

  def fix_point
    if self.point.blank? || self.point < 0
      self.point = 0
    elsif self.point > self.max_point
      self.point = self.max_point
    end
  end
end
