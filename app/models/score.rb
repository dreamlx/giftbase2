class Score < ActiveRecord::Base
  belongs_to :user
  attr_accessible :number
  validates :user,    presence: true
  validates :number,  presence: true
end
