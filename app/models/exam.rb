class Exam < ActiveRecord::Base
  belongs_to :unit
  belongs_to :user
  has_many :answers, dependent: :destroy

  attr_accessible :started_at, :stopped_at, :unit_id, :user_id, :answers_attributes

  accepts_nested_attributes_for :answers

  validates :unit, :user, presence: true

  state_machine :state, initial: :uploading do
    state :uploading, :placed, :reviewed

    event :finish_uploading do
      transition :uploading => :placed
    end
    after_transition :uploading => :placed, :do => [:auto_review]

    event :finish_review do
      transition :placed => :reviewed
    end
  end

  def duration
    if started_at.blank? or stopped_at.blank?
      0
    else
      stopped_at - started_at
    end
  end

  def total_point
    scoring_rule = YAML::load(File.open("#{Rails.root}/config/scoring_rule.yml"))
    math_rule = scoring_rule["math"]["one"] 
    wrong_counts = (answers.map{|a| a.point == 0 ? true : nil}.compact).size
    point = math_rule["sum_point"] - math_rule["deduct_point"]*wrong_counts
    point = 0 if point < 0
  end

  def max_point
    answers.map(&:max_point).sum
  end

  def unreviewed_count
    answers.unreviewed.count
  end

  def can_finish_review?
    unreviewed_count == 0
  end

  def auto_review
    answers.each(&:auto_review)
  end

  def accuracy
    format("%.2f", correct_counts.to_f/answers.size) 
  end

  def correct_counts
    i = 0
    answers.each do |answer|
      i += 1 if answer.point.to_f == answer.question_line_item.point.to_f
    end
    return i
  end

  # TODO: test data for development, remove it on production
  def self.generate_test_params(unit_id)
    unit = Unit.find(unit_id)

    params = {
      exam: {
        unit_id: unit_id,
        started_at: 2.hours.ago,
        stopped_at: 1.hours.ago,
        answers_attributes: []
      }
    }

    unit.question_line_items.each do |question_line_item|
      params[:exam][:answers_attributes] << case question_line_item.question.type
      when 'Question::SingleChoice'
        { question_line_item_id: question_line_item.id, image: nil, option_id: question_line_item.question.single_choice_options.first.id }
      when 'Question::MultipleChoice'
        { question_line_item_id: question_line_item.id, image: nil, option_ids: question_line_item.question.multiple_choice_option_ids }
      when 'Question::Brief'
        { question_line_item_id: question_line_item.id, image: nil, content: 'Lorem test data for brief question.' }
      when 'Question::FillInBlank'
        { question_line_item_id: question_line_item.id, image: nil, contents: question_line_item.question.fill_in_blank_solutions.count.times.map { |i| "Test fill in blank #{i}" } }
      when 'Question::Matching'
        { question_line_item_id: question_line_item.id, image: nil, matches: [] }
      end
    end

    params
  end
end
 