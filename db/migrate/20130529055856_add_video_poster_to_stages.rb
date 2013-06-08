class AddVideoPosterToStages < ActiveRecord::Migration
  def change
    add_column :stages, :video_poster, :string
  end
end
