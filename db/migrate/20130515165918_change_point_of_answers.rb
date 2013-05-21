class ChangePointOfAnswers < ActiveRecord::Migration
  def change
    change_column :answers, :point, :decimal, :precision => 8, :scale => 1
  end
end
