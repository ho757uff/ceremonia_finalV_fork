class AddImagesToAlbum < ActiveRecord::Migration[7.1]
  def change
    add_column :albums, :images, :json
  end
end
