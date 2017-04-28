class DestroyTables < ActiveRecord::Migration
  def change
  	drop_table :proposes
  end
end
