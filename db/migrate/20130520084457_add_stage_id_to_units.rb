class AddStageIdToUnits < ActiveRecord::Migration
  def change
    add_column :units, :stage_id, :integer
    add_index :units, :stage_id
  end
end
