class Answer < ActiveRecord::Base
  belongs_to :exam
  belongs_to :question_line_item

  delegate :question, to: :question_line_item

  store :data, accessors: [ :option_id, :option_ids, :content, :contents, :matches ]

  attr_accessible :comment, :point, :reviewed_at, :question_line_item_id, :option_id, :option_ids, :content, :contents, :matches

  scope :unreviewed, lambda { where('reviewed_at IS NULL') }
  scope :reviewed, lambda { where('reviewed_at NOT NULL') }

  default_value_for :point, 0

  def max_point
    question_line_item.point
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
end
