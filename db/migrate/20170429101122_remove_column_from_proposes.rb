class RemoveColumnFromProposes < ActiveRecord::Migration
  def change
    remove_column :proposes, :subject, :string
  end
end
