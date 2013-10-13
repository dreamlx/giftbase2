class Stage < ActiveRecord::Base
  mount_uploader :video, VideoUploader
  mount_uploader :video_poster, PosterUploader

  belongs_to :grade
  has_many :units, order: 'units.position'
  has_many :exams, through: :units
  has_many :answers, through: :exams
  has_and_belongs_to_many :users
  has_many :map_places, as: :placeable, dependent: :destroy
  
  attr_accessible :description, 
    :name, :price, 
    :video, :video_cache, :video_poster, 
    :video_poster_cache, :grade_id,
    :position

  validates :name, :price, presence: true

  acts_as_list scope: :grade

  def purchase(user)
    if (!user.stages.include?(self)) && user.credit.balance > self.price
      user.credit.add_expense(self)
      user.stages << self
      true
    else
      false
    end
  end

  def purchase?(user)
    user.blank? ? false : user.stages.include?(self) 
  end
end
