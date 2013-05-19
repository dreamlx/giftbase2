class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :number
      t.decimal :credit_quantity
      t.decimal :total, :precision => 8, :scale => 2
      t.string :state
      t.references :user

      t.timestamps
    end
    add_index :orders, :number
    add_index :orders, :state
    add_index :orders, :user_id
  end
end
