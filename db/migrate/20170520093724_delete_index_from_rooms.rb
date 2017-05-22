class DeleteIndexFromRooms < ActiveRecord::Migration
  def change
  	remove_index :rooms, name: "index_rooms_on_requestman_id_and_postman_id"
  end
end
