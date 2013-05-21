class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.references :user
      t.decimal :start_balance
      t.decimal :balance

      t.timestamps
    end
    add_index :credits, :user_id

    User.all.each { |u| u.create_credit }
  end
end
