class AddEventToEventLoc < ActiveRecord::Migration[7.1]
  def change
    add_reference :event_locations, :event
  end
end
