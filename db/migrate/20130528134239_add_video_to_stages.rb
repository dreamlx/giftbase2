class AddVideoToStages < ActiveRecord::Migration
  def change
    add_column :stages, :video, :string
  end
end
