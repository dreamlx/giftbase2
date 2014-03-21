class BriefSolution < ActiveRecord::Base
  belongs_to :question, class_name: 'Question::Brief'
  mount_uploader :image, ImageUploader

  validates :content, presence: true

  attr_accessible :content, :image, :image_cache
end
