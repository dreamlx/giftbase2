class AddStateToStagesUser < ActiveRecord::Migration
  def change
  	add_column :stages_users, :state, :string
  end
end
