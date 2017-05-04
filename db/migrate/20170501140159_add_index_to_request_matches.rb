class AddIndexToRequestMatches < ActiveRecord::Migration
  def change
  	add_index :request_matches, [:post_user_id, :request_user_id, :propose_id], unique: true, name: 'three_id_column_must_be_unique'
  end
end
