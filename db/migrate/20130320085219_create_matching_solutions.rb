class CreateMatchingSolutions < ActiveRecord::Migration
  def change
    create_table :matching_solutions do |t|
      t.references :question
      t.text :source
      t.text :target

      t.timestamps
    end
    add_index :matching_solutions, :question_id
  end
end
