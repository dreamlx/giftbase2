class AddPositionToGrade < ActiveRecord::Migration
  def change
    add_column :grades, :position, :integer
  end
end
