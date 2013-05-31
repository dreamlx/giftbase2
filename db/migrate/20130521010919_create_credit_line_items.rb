class CreateCreditLineItems < ActiveRecord::Migration
  def change
    create_table :credit_line_items do |t|
      t.decimal :amount, :precision => 8, :scale => 2
      t.references :credit
      t.references :order
      t.references :stage

      t.timestamps
    end
    add_index :credit_line_items, :credit_id
    add_index :credit_line_items, :order_id
    add_index :credit_line_items, :stage_id
  end
end
