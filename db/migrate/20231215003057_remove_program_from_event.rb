class RemoveProgramFromEvent < ActiveRecord::Migration[7.1]
  def change
    remove_column :events, :program, :text
  end
end
