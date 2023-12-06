class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.datetime :date
      t.string :city_name
      t.string :title
      t.text :program

      t.timestamps
    end
  end
end
