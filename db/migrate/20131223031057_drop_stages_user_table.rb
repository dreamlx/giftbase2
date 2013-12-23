class DropStagesUserTable < ActiveRecord::Migration
  def change
  	drop_table :stages_users
  end
end
