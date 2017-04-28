class DestroyTable < ActiveRecord::Migration
  def change
  	drop_table :proposes
  end
end
