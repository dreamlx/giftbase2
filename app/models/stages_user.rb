class StagesUser < ActiveRecord::Base
  attr_accessible :stage_id, :user_id

  state_machine :state, initial: :lock do 
  	state :lock, :unlock

  	event :unlock_stage do
  	  transition :lock => :unlock
  	end
  end
end