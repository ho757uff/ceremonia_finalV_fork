class AddEventToEventLocation < ActiveRecord::Migration[7.1]
  def change
    add_reference :event_locations, :user
  end
end
