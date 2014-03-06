class AddClassNoToUser < ActiveRecord::Migration
  def change
    add_column :users, :class_no, :string
  end
end
