class AddStatusToGrade < ActiveRecord::Migration
  def change
    add_column :grades, :state, :string
  end
end
