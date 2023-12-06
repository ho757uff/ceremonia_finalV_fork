class CreateEventLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :event_locations do |t|
      t.datetime :date

      t.timestamps
    end
  end
end
