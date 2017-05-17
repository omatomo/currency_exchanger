class ChangeColumnDefaultToProposes < ActiveRecord::Migration
  def change
  	change_column_default(:proposes, :likes_count, nil)
  end
end
