class MatchingSolution < ActiveRecord::Base
  belongs_to :question
  attr_accessible :source, :target, :_destroy

  scope :connected, lambda { where("(source > '') AND (target > '')") }

  before_save :update_hashed

  protected
  
  def update_hashed
    self.hashed_source = Digest::MD5.hexdigest(source)
    self.hashed_target = Digest::MD5.hexdigest(target)
  end
end
