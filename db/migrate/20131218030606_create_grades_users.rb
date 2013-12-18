class CreateGradesUsers < ActiveRecord::Migration
  def change
  	create_table :grades_users, id: false do |t|
  	  t.references :grade
  	  t.references :user
  	end

  	add_index :grades_users, :grade_id
  	add_index :grades_users, :user_id
  end
end
