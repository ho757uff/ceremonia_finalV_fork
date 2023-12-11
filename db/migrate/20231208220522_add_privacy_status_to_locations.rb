class AddPrivacyStatusToLocations < ActiveRecord::Migration[7.1]
  def change
    add_column :locations, :privacy_status, :integer
  end
end
