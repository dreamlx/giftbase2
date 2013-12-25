class UserStage < ActiveRecord::Base
  attr_accessible :user_id, :stage_id
  belongs_to :user
  belongs_to :stage
  state_machine :state, initial: :lock do
  	state :lock, :unlock

  	event :unlock_stage do
  	  transition :lock => :unlock
  	end
  end
end
