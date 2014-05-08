class AddStageToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :stage_id, :integer
  end
end
