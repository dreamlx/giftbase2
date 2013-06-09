class AddGradeIdToStages < ActiveRecord::Migration
  def change
    add_column :stages, :grade_id, :integer
    add_index :stages, :grade_id
  end
end
