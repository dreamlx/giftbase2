class CreateQuestionLineItems < ActiveRecord::Migration
  def change
    create_table :question_line_items do |t|
      t.references :question
      t.references :question_group
      t.integer :position
      t.decimal :point, :precision => 8, :scale => 1

      t.timestamps
    end
    add_index :question_line_items, :question_id
    add_index :question_line_items, :question_group_id
    add_index :question_line_items, :position
  end
end
