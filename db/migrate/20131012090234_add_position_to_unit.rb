class AddPositionToUnit < ActiveRecord::Migration
  def change
    add_column :units, :position, :integer
  end
end
