class DeleteIndexFromRequestMatches < ActiveRecord::Migration
  def change
  	remove_index :request_matches, name: "three_id_column_must_be_unique"
  end
end
