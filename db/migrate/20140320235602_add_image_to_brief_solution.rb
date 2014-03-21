class AddImageToBriefSolution < ActiveRecord::Migration
  def change
    add_column :brief_solutions, :image, :string
  end
end
