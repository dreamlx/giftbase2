class DropTableGradesUsers < ActiveRecord::Migration
  def change
  	drop_table :grades_users
  end
end
