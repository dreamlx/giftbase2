class Post < ActiveRecord::Base
  after_save :remove_previously_stored_image
  attr_accessible :image
  mount_uploader :image, ImageUploader
  validates :image, presence: true
end
