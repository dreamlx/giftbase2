class RemoveColumnLevelToQuestion < ActiveRecord::Migration
  def change
  	remove_column :questions, :level
  end
end
