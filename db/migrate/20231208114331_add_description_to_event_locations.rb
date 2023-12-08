class AddDescriptionToEventLocations < ActiveRecord::Migration[7.1]
  def change
    add_column :event_locations, :description, :text
  end
end
