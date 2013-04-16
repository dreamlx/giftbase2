class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :type
      t.text :subject
      t.text :hint
      t.integer :level

      t.timestamps
    end
    add_index :questions, :type
  end
end
