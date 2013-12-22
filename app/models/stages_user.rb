class StagesUser < ActiveRecord::Base
  attr_accessible :stage_id, :user_id, :state
end