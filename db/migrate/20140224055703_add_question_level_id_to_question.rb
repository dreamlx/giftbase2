class AddQuestionLevelIdToQuestion < ActiveRecord::Migration
  def change
  	add_column :questions, :question_level_id, :integer
  end
end
