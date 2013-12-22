class GradesUser < ActiveRecord::Base
  attr_accessible :grade_id, :user_id
end