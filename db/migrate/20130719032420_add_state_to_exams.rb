class AddStateToExams < ActiveRecord::Migration
  def change
    add_column :exams, :state, :string
    add_index :exams, :state

    Exam.all.each do |e|
      e.update_column(:state, 'uploading')
    end
  end
end
