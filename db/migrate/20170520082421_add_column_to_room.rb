class AddColumnToRoom < ActiveRecord::Migration
  def change
    add_reference :rooms, :propose, index: true, foreign_key: true
  end
end
