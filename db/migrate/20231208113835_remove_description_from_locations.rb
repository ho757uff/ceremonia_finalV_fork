class RemoveDescriptionFromLocations < ActiveRecord::Migration[7.1]
  def change
    remove_column :locations, :description, :text
  end
end
