class CreateQuestionGroups < ActiveRecord::Migration
  def change
    create_table :question_groups do |t|
      t.string :name
      t.text :description
      t.integer :position
      t.references :unit

      t.timestamps
    end
    add_index :question_groups, :position
    add_index :question_groups, :unit_id
  end
end
