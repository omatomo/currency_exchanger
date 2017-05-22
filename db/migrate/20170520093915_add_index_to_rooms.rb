class AddIndexToRooms < ActiveRecord::Migration
  def change
  	add_index :rooms, [:requestman_id, :propose_id], unique: true
  end
end
