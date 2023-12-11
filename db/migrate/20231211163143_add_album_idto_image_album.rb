class AddAlbumIdtoImageAlbum < ActiveRecord::Migration[7.1]
  def change
    add_reference :image_albums, :album
    
  end
end

