class AddIndexToRequestMatche < ActiveRecord::Migration
  def change
  	add_index :request_matches, :propose_id, unique: true, name: "propose_id_must_be_unique"
  end
end
