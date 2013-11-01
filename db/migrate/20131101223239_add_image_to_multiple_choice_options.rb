class AddImageToMultipleChoiceOptions < ActiveRecord::Migration
  def change
    add_column :multiple_choice_options, :image, :string
  end
end
