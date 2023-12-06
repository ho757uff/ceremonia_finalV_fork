class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :place
      t.string :address
      t.text :description

      t.timestamps
    end
  end
end
