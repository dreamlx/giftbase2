class Stage < ActiveRecord::Base
  mount_uploader :video, VideoUploader
  mount_uploader :video_poster, PosterUploader

  belongs_to :grade
  has_many :units
  has_and_belongs_to_many :users
  
  attr_accessible :description, :name, :price, :video, :video_cache, :video_poster, :video_poster_cache, :grade_id

  validates :name, :price, presence: true

  def purchase(user)
    if (!user.stages.include?(self)) && user.credit.balance > self.price
      user.credit.add_expense(self)
      user.stages << self
    end
  end
end
