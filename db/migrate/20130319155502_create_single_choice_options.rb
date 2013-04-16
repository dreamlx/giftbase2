class CreateSingleChoiceOptions < ActiveRecord::Migration
  def change
    create_table :single_choice_options do |t|
      t.references :question
      t.text :content
      t.integer :position
      t.string :sequence
      t.boolean :correct

      t.timestamps
    end
    add_index :single_choice_options, :question_id
    add_index :single_choice_options, :position
    add_index :single_choice_options, :correct
  end
end
