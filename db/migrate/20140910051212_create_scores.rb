class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.references :user
      t.float :number

      t.timestamps
    end
    add_index :scores, :user_id
  end
end
