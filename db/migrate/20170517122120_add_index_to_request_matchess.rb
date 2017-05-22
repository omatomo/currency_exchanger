class AddIndexToRequestMatchess < ActiveRecord::Migration
  def change
  	add_index :request_matches, [:request_user_id, :propose_id], unique: true
  end
end
