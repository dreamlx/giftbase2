class UserUnit < ActiveRecord::Base
  attr_accessible :unit_id, :user_id
  
  belongs_to :user
  belongs_to :unit

  state_machine :state, initial: :lock do
  	state :lock, :unlock

  	event :unlock_unit do
  	  transition :lock => :unlock
  	end
  end
end
