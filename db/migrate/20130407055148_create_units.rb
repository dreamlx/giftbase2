class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name
      t.text :description
      t.integer :exam_minutes

      t.timestamps
    end
  end
end
