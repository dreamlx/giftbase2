class MatchingSolution < ActiveRecord::Base
  belongs_to :question
  attr_accessible :source, :target, :_destroy
end
