class CreateFillInBlankSolutions < ActiveRecord::Migration
  def change
    create_table :fill_in_blank_solutions do |t|
      t.references :question
      t.text :content
      t.integer :position

      t.timestamps
    end
    add_index :fill_in_blank_solutions, :question_id
    add_index :fill_in_blank_solutions, :position
  end
end
