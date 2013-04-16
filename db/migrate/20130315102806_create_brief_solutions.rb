class CreateBriefSolutions < ActiveRecord::Migration
  def change
    create_table :brief_solutions do |t|
      t.references :question
      t.text :content

      t.timestamps
    end
    add_index :brief_solutions, :question_id
  end
end
