class RemoveUserFromEventLocation < ActiveRecord::Migration[7.1]
  def change
    remove_column :event_locations, :user_id
  end
end
