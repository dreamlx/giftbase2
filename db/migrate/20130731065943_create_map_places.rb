class CreateMapPlaces < ActiveRecord::Migration
  def change
    create_table :map_places do |t|
      t.integer :x
      t.integer :y
      t.string :version
      t.references :placeable, polymorphic: true

      t.timestamps
    end
    add_index :map_places, [:placeable_id, :placeable_type]
  end
end
