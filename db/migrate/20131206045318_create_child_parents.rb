class CreateChildParents < ActiveRecord::Migration
  def change
    create_table :child_parents do |t|
      t.integer :child_id
      t.integer :parent_id
      t.timestamps
    end
  end
end
