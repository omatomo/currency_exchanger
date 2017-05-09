class AddColumnToPropose < ActiveRecord::Migration
  def change
    add_column :proposes, :likes_count, :integer
  end
end
