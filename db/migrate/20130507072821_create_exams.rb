class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.references :unit
      t.references :user
      t.datetime :started_at
      t.datetime :stopped_at

      t.timestamps
    end
    add_index :exams, :unit_id
    add_index :exams, :user_id
  end
end
