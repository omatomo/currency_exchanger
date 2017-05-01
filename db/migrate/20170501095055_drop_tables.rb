class DropTables < ActiveRecord::Migration
  def change
  	drop_table :request_matches
  end
end
