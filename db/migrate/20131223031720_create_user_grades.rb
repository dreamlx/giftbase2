class CreateUserGrades < ActiveRecord::Migration
  def change
    create_table :user_grades do |t|
      t.integer :user_id
      t.integer :grade_id
      t.string :state
      t.timestamps
    end
  end
end
