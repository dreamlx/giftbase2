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
      user.credit.add_expense_stage(self)
      user.stages << self
      self.units.each do |unit|
        user.units << unit
      end
      true
    else
      false
    end
  end

  def purchase?(user)
    user.blank? ? false : user.stages.include?(self) 
  end

  def stage_percentage_complete(user)
    complete_units = self.exams.select("unit_id").where("user_id = #{user.id}").uniq
    percent = (complete_units.length.to_f/self.units.length)
  end

  #TOTD  state_machine is wrong 
  def unlock(user)
    user_stage = StagesUser.where(user_id: user.id, stage_id: self.id).first
    user_stage.state = "unlock"
    user_stage.save
  end

  def unlock?(user)
    user_stage = StagesUser.where(user_id: user.id, stage_id: self.id).first
    if user_stage.state == "unlock"
      return true
    else
      return false
    end
  end
end
