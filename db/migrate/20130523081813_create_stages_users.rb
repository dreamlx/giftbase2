class CreateStagesUsers < ActiveRecord::Migration
  def change
    create_table :stages_users, id: false do |t|
      t.references :stage
      t.references :user
    end

    add_index :stages_users, :stage_id
    add_index :stages_users, :user_id
  end
end
