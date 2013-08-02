class Picture < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  belongs_to :imageable, polymorphic: true
  attr_accessible :name, :image, :image_cache, :version

  validates :name, :version, presence: true
end
