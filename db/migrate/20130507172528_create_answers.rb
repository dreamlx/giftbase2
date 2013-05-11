class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :exam
      t.references :question_line_item
      t.text :data
      t.decimal :point
      t.text :comment
      t.datetime :reviewed_at

      t.timestamps
    end
    add_index :answers, :exam_id
    add_index :answers, :question_line_item_id
    add_index :answers, :reviewed_at
  end
end
