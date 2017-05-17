class ChangeColumnDefaultToLikes < ActiveRecord::Migration
  def change
  	change_column_default(:proposes, :likes_count, 0)
  end
end
