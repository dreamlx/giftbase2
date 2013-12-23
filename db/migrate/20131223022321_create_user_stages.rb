class CreateUserStages < ActiveRecord::Migration
  def change
    create_table :user_stages do |t|
      t.integer :user_id
      t.integer :stage_id
      t.string :state
      t.timestamps
    end
  end
end
