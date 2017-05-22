class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :requestman_id
      t.integer :postman_id

      t.timestamps null: false
    end
    add_index :rooms, :requestman_id
    add_index :rooms, :postman_id
    add_index :rooms, [:requestman_id, :postman_id], unique: true
  end
end
