class AddEventIdToAlbum < ActiveRecord::Migration[7.1]
  def change
    add_reference :albums, :event
  end
end
