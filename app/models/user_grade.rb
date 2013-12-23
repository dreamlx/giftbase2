class UserGrade < ActiveRecord::Base
  attr_accessible :user_id, :grade_id

  belongs_to :user
  belongs_to :grade
end
