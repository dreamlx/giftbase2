class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :name
      t.string :version
      t.string :image
      t.references :imageable, polymorphic: true

      t.timestamps
    end
    add_index :pictures, [:imageable_id, :imageable_type]
  end
end
