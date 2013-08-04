class MapPlace < ActiveRecord::Base
  belongs_to :placeable, polymorphic: true

  attr_accessible :version, :x, :y

  validates :x, :y, :version, presence: true
end
