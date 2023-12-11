class CreateImageAlbums < ActiveRecord::Migration[7.1]
  def change
    create_table :image_albums do |t|
      t.string :title
      

      t.timestamps
    end
  end
end
