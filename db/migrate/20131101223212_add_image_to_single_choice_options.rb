class AddImageToSingleChoiceOptions < ActiveRecord::Migration
  def change
    add_column :single_choice_options, :image, :string
  end
end
