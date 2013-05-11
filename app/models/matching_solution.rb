class MatchingSolution < ActiveRecord::Base
  belongs_to :question
  attr_accessible :source, :target, :_destroy

  def hashed_source
    Digest::MD5.new.digest(source)
  end

  def hashed_target
    Digest::MD5.new.digest(target)
  end
end
