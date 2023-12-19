class AddUserToImage < ActiveRecord::Migration[7.1]
  def change
    add_reference :images, :user, foreign_key: true
  end
end
