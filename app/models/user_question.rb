class UserQuestion < ActiveRecord::Base
  attr_accessible :question_id, :user_id
  
  belongs_to :user
  belongs_to :question
end
