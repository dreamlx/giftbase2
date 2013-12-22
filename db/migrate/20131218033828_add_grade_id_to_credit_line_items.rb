class AddGradeIdToCreditLineItems < ActiveRecord::Migration
  def change
  	change_table :credit_line_items do |t|
      t.references :grade, index: true
  	end
  end

end
