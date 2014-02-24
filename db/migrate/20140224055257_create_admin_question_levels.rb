class CreateAdminQuestionLevels < ActiveRecord::Migration
  def change
    create_table :question_levels do |t|
      t.string :name
      t.timestamps
    end
  end
end
