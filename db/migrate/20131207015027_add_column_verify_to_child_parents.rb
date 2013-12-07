class AddColumnVerifyToChildParents < ActiveRecord::Migration
  def change
  	add_column :child_parents, :verify_parent, :boolean, :default => false
  end
end
