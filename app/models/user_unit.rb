class UserUnit < ActiveRecord::Base
  attr_accessible :unit_id, :user_id
  
  belongs_to :user
  belongs_to :unit
end
