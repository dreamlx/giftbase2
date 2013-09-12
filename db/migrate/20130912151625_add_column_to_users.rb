class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birthday, :date
    add_column :users, :home_address, :string
    add_column :users, :school_name, :string
    add_column :users, :school_address, :string
    add_column :users, :qq, :string
    add_column :users, :parent_name, :string
  end
end
