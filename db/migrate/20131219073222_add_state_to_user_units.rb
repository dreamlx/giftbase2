class AddStateToUserUnits < ActiveRecord::Migration
  def change
  	add_column :user_units, :state, :string
  end
end
