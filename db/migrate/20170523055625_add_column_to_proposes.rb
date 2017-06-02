class AddColumnToProposes < ActiveRecord::Migration
  def change
    add_column :proposes, :gotime, :text
  end
end
