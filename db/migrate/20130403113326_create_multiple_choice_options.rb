class CreateMultipleChoiceOptions < ActiveRecord::Migration
  def change
    create_table :multiple_choice_options do |t|
      t.references :question
      t.text :content
      t.integer :position
      t.string :sequence
      t.boolean :correct

      t.timestamps
    end
    add_index :multiple_choice_options, :question_id
    add_index :multiple_choice_options, :position
    add_index :multiple_choice_options, :correct
  end
end
